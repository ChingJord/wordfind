class Wordfind

    attr_reader :grid, :found_words

    def start
        puts 'Welcome to Wordfind'
        puts 'Choose a grid size. eg 5 will create a 5x5 grid'
        @found_words = Array.new
    end

    def drawgrid(n)
        if n > 0    # checks for negative and non integer
            @grid = Array.new(n)
            n.times do |row_index|
                @grid[row_index] = Array.new(n)
                n.times do |column_index|
                    @grid[row_index][column_index] = (65 + rand(26)).chr.upcase
                end
            end
            @grid
            check_words
        else
            puts 'invalid input'
            'invalid input'
        end
    end

    def check_words
        grid.each { |line|
            line.each_with_index { |slot, index|
                get_words.each { |word|
                    if slot == word.to_s[0]
                        # Check horizontal matches
                        check_right(line, word)
                        check_left(line, word)
                        # Check vertical matches
                        column = get_column(index)  # get the current column
                        check_up(column, word)
                        check_down(column, word)
                    end
                }
            }
        }
        report
    end

    def check_right(line, word)
        # Called once the first character has been hit.
        # Checks whether the word is contained in the row
        # reading left to right
        line_string = line.join('')
        if line_string.include? word
            found_words.push(word)
        end
    end

    def check_left(line, word)
        # Called once the first character has been hit.
        # Checks whether the word is contained in the row
        # reading right to left
        line_string = line.join('').reverse
        if line_string.include? word
            found_words.push(word)
        end
    end

    def check_down(column, word)
        # Called once the first character has been hit.
        # Checks whether the word is contained in the column
        # reading top to bottom
        column_string = column.join('')
        if column_string.include? word
            found_words.push(word)
        end
    end

    def check_up(column, word)
        # Called once the first character has been hit.
        # Checks whether the word is contained in the column
        # reading bottom to top
        column_string = column.join('').reverse
        if column_string.include? word
            found_words.push(word)
        end
    end

    def get_column(index)
        # Returns the column where the first character was hit
        column = Array.new
        grid.each { |line|
            column.push(line[index])
        }
        column
    end

    def get_words
        # Returns an array of the first wirds in each line of a text file.
        lines = File.readlines('../lib/dict.txt').reject(&:empty?)
        lines.map do |line|
            line.split.first
        end
    end

    def report
        puts '**********'
        if found_words.length > 0
            puts 'Words found are:'
            puts found_words
        else
            puts 'No words found'
        end
        puts '**********'
    end

end

# Game initialisation for user testing.
wordfind = Wordfind.new()
wordfind.start

# Draw grid from user input
n = gets.to_i ||= 0
wordfind.drawgrid(n)
