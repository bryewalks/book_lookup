require_relative 'spec_helper'

describe Book do
  describe '#initialize' do
    context 'when title given' do
      it 'should use given title' do
        title = 'Fear and Loathing'
        book = Book.new(title: title)
        expect(book.title).to eq(title)
      end
    end

    context 'when no title given' do
      it 'should be unknown' do
        book = Book.new(title: nil)
        expect(book.title).to eq('Unknown')
      end
    end

    context 'when author given' do
      it 'should use given author' do
        author = 'Hunter S Thompson'
        book = Book.new(authors: author)
        expect(book.authors).to eq(author)
      end
    end

    context 'when no author given' do
      it 'should be unknown' do
        book = Book.new(authors: nil)
        expect(book.authors).to eq(['Unknown'])
      end
    end

    context 'when publisher given' do
      it 'should use given publisher' do
        publisher = 'Random House'
        book = Book.new(publisher: publisher)
        expect(book.publisher).to eq('Random House')
      end
    end

    context 'when no publisher given' do
      it 'should be unknown' do
        book = Book.new(publisher: nil)
        expect(book.publisher).to eq('Unknown')
      end
    end
  end

  describe '#format_authors' do
    context 'when author is unknown' do
      it 'should return unknown' do
        book = Book.new(authors: nil)
        expect(book.format_authors).to eq('Unknown')
      end
    end

    context 'when one author' do
      it 'should return that author' do
        book = Book.new(authors: ['brye'])
        expect(book.format_authors).to eq('brye')
      end
    end

    context 'when multiple authors' do
      it 'should return authors seperated with ,' do
        book = Book.new(authors: ['brye', 'walker'])
        expect(book.format_authors).to eq('brye, walker')
      end
    end
  end
end