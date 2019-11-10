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
end