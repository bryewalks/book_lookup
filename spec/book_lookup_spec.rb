require_relative 'spec_helper'

describe BookLookup do

  let(:booklookup) { BookLookup.new } 

  describe '#search_books' do
    context 'when google api finds books' do
      it 'should call display_books' do
        expect(booklookup).to receive(:display_books)
        booklookup.search_books("fear and loathing")
      end
    end

    context 'when google api finds no books' do
      it 'should inform you' do
        expect { booklookup.search_books("asdfasdf asdf adasf") }.to output("no matches...\n").to_stdout
      end
    end
  end

  describe '#display_books' do

    let(:book) { Book.new(title: "title", publisher: "publisher", author: "author") }

    it 'should display each book given' do
      book_array = []
      book_array << book
      expect { booklookup.display_books(book_array) }.to output("        Book #1        \nTitle: #{book.title}\nAuthor(s): #{book.author}\nPublisher: #{book.publisher}\n\n").to_stdout
    end
  end

  describe '#continue?' do
    context "user enters 'y'" do
      before do
        allow(booklookup).to receive(:user_input).and_return('y')
      end

      it 'should return true' do
        expect(booklookup.continue?).to eq(true)
      end
    end

    context "user enters 'n'" do
      before do
        allow(booklookup).to receive(:user_input).and_return('n')
      end

      it 'should return false' do
        expect(booklookup.continue?).to eq(false)
      end
    end
  end

  describe '#add_to_saved?' do
    context "user enters 'n'" do
      before do
        allow(booklookup).to receive(:user_input).and_return('n')
        allow(booklookup).to receive(:puts).and_return('')
      end

      it 'should call continue?' do
        expect(booklookup).to receive(:continue?)
        booklookup.add_to_saved?
      end

      it 'should return false' do
        expect(booklookup.add_to_saved?).to eq(false)
      end
    end

    context "user enters 'y'" do
      before do 
        allow(booklookup).to receive(:user_input).and_return('y')
      end

      it 'should ask use if they want to add selection' do
        expect { booklookup.add_to_saved? }.to output("Would you like to add selections to reading list? y/n\n").to_stdout
      end
      
      it 'should return true' do
        allow(booklookup).to receive(:puts).and_return('')
        expect(booklookup.add_to_saved?).to eq(true)
      end
    end

  end

  describe '#search_again?' do
    context "user enters 'n'" do
      before do
        allow(booklookup).to receive(:user_input).and_return('n')
        allow(booklookup).to receive(:puts).and_return('')
      end

      it 'should call continue?' do
        expect(booklookup).to receive(:continue?)
        booklookup.search_again?
      end
      
      it 'should return false' do
        expect(booklookup.search_again?).to eq(false)
      end
    end
    
    context "user enters 'y'" do
      before do 
        allow(booklookup).to receive(:user_input).and_return('y')
      end

      it 'should ask use if they want to search again' do
        expect { booklookup.search_again? }.to output("Search again? y/n\n").to_stdout
      end

      it 'should return true' do
        allow(booklookup).to receive(:puts).and_return('')
        expect(booklookup.search_again?).to eq(true)
      end
    end

  end
end