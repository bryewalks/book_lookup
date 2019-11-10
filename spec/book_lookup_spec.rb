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
    let(:book_array) { [book] }

    it 'should display each book given' do
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

  describe '#search_path' do
    before do
      allow(booklookup).to receive(:puts).and_return('')
    end

    it 'should call search_books with 1 argument' do
      allow(booklookup).to receive(:user_input).and_return('1985')
      expect(booklookup).to receive(:search_books).with('1985')
      booklookup.search_path
    end
  end

  describe '#select_book' do
    before do
      allow(booklookup).to receive(:puts).and_return('')
    end

    it 'should call add_book with 1 argument' do
      allow(booklookup).to receive(:user_input).and_return('1')
      expect(booklookup).to receive(:add_book).with(1)
      booklookup.select_book
    end
  end

  describe '#add_book' do
    let(:book_1) { Book.new(title: "title_1", publisher: "publisher_1", author: "author_1") }
    let(:book_2) { Book.new(title: "title_2", publisher: "publisher_2", author: "author_2") }
    let(:book_3) { Book.new(title: "title_3", publisher: "publisher_3", author: "author_3") }
    let(:book_4) { Book.new(title: "title_4", publisher: "publisher_4", author: "author_4") }
    let(:book_5) { Book.new(title: "title_5", publisher: "publisher_5", author: "author_5") }

    before do 
      booklookup.found_books = [book_1, book_2, book_3, book_4, book_5]
    end

    context 'when adding one' do
      it 'should move books from found_books to reading_list' do
        booklookup.add_book(1)
        expect(booklookup.reading_list.length).to eq(1)
      end

      it 'should move the correct book' do
        booklookup.add_book(5)
        expect(booklookup.reading_list.first).to eq(book_5)
      end
    end
    context 'when adding multiple' do
      it 'should add more than one book' do
        booklookup.add_book(1)
        booklookup.add_book(2)
        expect(booklookup.reading_list.length).to eq(2)
      end

      it 'should not overide other books' do
        booklookup.add_book(1)
        booklookup.add_book(2)
        booklookup.add_book(3)
        booklookup.add_book(4)
        expect(booklookup.reading_list.first).to eq(book_1)
      end
    end
  end
end