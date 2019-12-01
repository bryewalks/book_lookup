require_relative 'spec_helper'

class BookLookup
  attr_accessor :reading_list, :found_books
end

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
        expect { booklookup.search_books("asdfasdf asdf adasf") }.to output("No matches...\n").to_stdout
      end
    end
  end

  describe '#display_books' do

    let(:book) { Book.new(title: "title", publisher: "publisher", authors: ["author"]) }
    let(:book_array) { [book] }

    it 'should display each book given' do
      expect { booklookup.display_books(book_array) }.to output("        Book #1        \nTitle: #{book.title}\nAuthor(s): #{book.format_authors}\nPublisher: #{book.publisher}\n\n").to_stdout
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

  describe '#add_another?' do
    context "user enters 'n'" do
      before do
        allow(booklookup).to receive(:user_input).and_return('n')
        allow(booklookup).to receive(:puts).and_return('')
      end

      it 'should call continue?' do
        expect(booklookup).to receive(:continue?)
        booklookup.add_another?
      end
      
      it 'should return false' do
        expect(booklookup.add_another?).to eq(false)
      end
    end
    
    context "user enters 'y'" do
      before do 
        allow(booklookup).to receive(:user_input).and_return('y')
      end

      it 'should ask use if they want to add another' do
        expect { booklookup.add_another? }.to output("Add another? y/n\n").to_stdout
      end

      it 'should return true' do
        allow(booklookup).to receive(:puts).and_return('')
        expect(booklookup.add_another?).to eq(true)
      end
    end
  end

  describe '#run_program' do
    context 'when option 1' do
      it 'should call search_path' do
        allow(booklookup).to receive(:user_input).and_return('1', '3')
        expect(booklookup).to receive(:search_path)
        booklookup.run_program
      end
    end  

    context 'when option 2' do
      it 'should call reading_list_path' do
        allow(booklookup).to receive(:user_input).and_return('2', '3')
        expect(booklookup).to receive(:reading_list_path)
        booklookup.run_program
      end
    end

    context 'when option 3' do
      it 'should say good-bye' do
        allow(booklookup).to receive(:user_input).and_return('3')
        allow(booklookup).to receive(:display_options).and_return('')
        expect { booklookup.run_program }.to output("Good-bye\n").to_stdout
      end
    end

    context 'when other option' do
      it 'should say not a valid option' do
        allow(booklookup).to receive(:user_input).and_return('10', '3')
        allow(booklookup).to receive(:display_options).and_return('')
        allow(booklookup).to receive(:sleep).and_return('')
        expect { booklookup.run_program }.to output("Not a valid option\nGood-bye\n").to_stdout
      end
    end
  end

  describe '#search_path' do
    before do
      allow(booklookup).to receive(:puts).and_return('')
      booklookup.found_books = []
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
    let(:book_1) { Book.new(title: "title_1", publisher: "publisher_1", authors: "author_1") }
    let(:book_2) { Book.new(title: "title_2", publisher: "publisher_2", authors: "author_2") }
    let(:book_3) { Book.new(title: "title_3", publisher: "publisher_3", authors: "author_3") }
    let(:book_4) { Book.new(title: "title_4", publisher: "publisher_4", authors: "author_4") }
    let(:book_5) { Book.new(title: "title_5", publisher: "publisher_5", authors: "author_5") }

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

  describe '#reading_list_path' do

    let(:book_1) { Book.new(title: "title_1", publisher: "publisher_1", authors: "author_1") }

    before do 
      allow(booklookup).to receive(:gets).and_return('')
    end

    context 'when no books in reading list' do
      it 'should inform you no books in reading list' do
        expect { booklookup.reading_list_path }.to output("You have no books in your reading list!\nPress enter to return\n").to_stdout
      end
    end

    context 'when books in reading list' do
      before do
        booklookup.reading_list = [book_1]
      end

      it 'should display the books' do
        allow(booklookup).to receive(:puts).and_return('')
        expect(booklookup).to receive(:display_books).with(booklookup.reading_list)
        booklookup.reading_list_path
      end
    end
  end

  describe '#valid_title' do
    context 'when no input given' do
      it 'should ask for a valid book title' do
        allow(booklookup).to receive(:user_input).and_return('', 'valid title')
        expect { booklookup.valid_title }.to output("Please enter a valid book title.\n").to_stdout
      end
    end

    context 'when spaces given' do
      it 'should ask for a valid book title' do
        allow(booklookup).to receive(:user_input).and_return('  ', 'valid title')
        expect { booklookup.valid_title }.to output("Please enter a valid book title.\n").to_stdout
      end
    end

    context 'when leading spaces given' do
      it 'should return title with no leading spaces' do
        allow(booklookup).to receive(:user_input).and_return('    Fight Club')
        expect(booklookup.valid_title).to eq('Fight Club')
      end
    end

    context 'when trailing spaces given' do
      it 'should return title with no trailing spaces' do
        allow(booklookup).to receive(:user_input).and_return('Fight Club    ')
        expect(booklookup.valid_title).to eq('Fight Club')
      end
    end

    context 'when valid input given' do
      it 'should return title' do
        allow(booklookup).to receive(:user_input).and_return('Fight Club')
        expect(booklookup.valid_title).to eq('Fight Club')
      end
    end
  end
end