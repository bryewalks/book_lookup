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
        expect(book.title).to eq("Unknown")
      end
    end

    context 'when authors given' do

    end

    context 'when no authors given' do
    
    end

    context 'when publisher given' do

    end

    context 'when no publisher given' do
    
    end
    
  end
end