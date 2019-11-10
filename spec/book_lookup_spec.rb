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
      it 'should return true' do
        allow(booklookup).to receive(:user_input).and_return('y')
        expect(booklookup.continue?).to eq(true)
      end
    end

    context "user enters 'n'" do
      it 'should return false' do
        allow(booklookup).to receive(:user_input).and_return('n')
        expect(booklookup.continue?).to eq(false)
      end
    end
  end

  describe '#add_to_saved?' do
    it 'should ask use if they want to add selection' do
      allow(booklookup).to receive(:user_input).and_return('n')
      expect { booklookup.add_to_saved? }.to output("Would you like to add selections to reading list? y/n\n").to_stdout
    end

    it 'should call continue?' do
      allow(booklookup).to receive(:user_input).and_return('n')
      expect(booklookup).to receive(:continue?)
      booklookup.add_to_saved?
    end

    context "user enters 'y'" do
      it 'should return true' do
        allow(booklookup).to receive(:user_input).and_return('y')
        expect(booklookup.add_to_saved?).to eq(true)
      end
    end

    context "user enters 'n'" do
      it 'should return false' do
        allow(booklookup).to receive(:user_input).and_return('n')
        expect(booklookup.add_to_saved?).to eq(false)
      end
    end
  end

  describe '#search_again?' do
    it 'should ask use if they want to search again' do
      allow(booklookup).to receive(:user_input).and_return('n')
      expect { booklookup.search_again? }.to output("Search again? y/n\n").to_stdout
    end

    it 'should call continue?' do
      allow(booklookup).to receive(:user_input).and_return('n')
      expect(booklookup).to receive(:continue?)
      booklookup.search_again?
    end

    context "user enters 'y'" do
      it 'should return true' do
        allow(booklookup).to receive(:user_input).and_return('y')
        expect(booklookup.search_again?).to eq(true)
      end
    end

    context "user enters 'n'" do
      it 'should return false' do
        allow(booklookup).to receive(:user_input).and_return('n')
        expect(booklookup.search_again?).to eq(false)
      end
    end
  end
end