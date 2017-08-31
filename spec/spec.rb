require '../lib/wordfind'
describe 'Wordfind' do

    describe 'placement' do

        it 'should render an N x N grid' do
            wordfind = Wordfind.new()
            wordfind.start
            wordfind.drawgrid(2)
            expect(wordfind.grid.length).to eq 2
        end

        it 'should reject negative inputs' do
            wordfind = Wordfind.new()
            wordfind.start
            expect(wordfind.drawgrid(-2)).to eq 'invalid input'
        end

        it 'should reject non integer inputs' do
            wordfind = Wordfind.new()
            wordfind.start
            expect(wordfind.drawgrid('a'.to_i)).to eq 'invalid input'
        end

        it 'should add words found left to right' do
            wordfind = Wordfind.new()
            wordfind.start
            wordfind.check_right(["A","B","C","D"], "BC")
            expect(wordfind.found_words).to eq ["BC"]
        end

        it 'should add words found Right to left' do
            wordfind = Wordfind.new()
            wordfind.start
            wordfind.check_left(["A","B","C","D"], "BA")
            expect(wordfind.found_words).to eq ["BA"]
        end

        it 'should add words found bottom to top' do
            wordfind = Wordfind.new()
            wordfind.start
            wordfind.check_up(["A","B","C","D"], "BA")
            expect(wordfind.found_words).to eq ["BA"]
        end

        it 'should add words found top to bottom' do
            wordfind = Wordfind.new()
            wordfind.start
            wordfind.check_down(["A","B","C","D"], "BC")
            expect(wordfind.found_words).to eq ["BC"]
        end

    end

end
