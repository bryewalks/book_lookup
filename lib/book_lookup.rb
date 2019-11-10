require 'http'
require_relative 'book'

class BookLookup
  def search_books(title)
    #format title to work with googles api regex to replace one or more spaces with underscore
    title = title.gsub(/ +/, '_')
    response = HTTP.get("https://www.googleapis.com/books/v1/volumes?q=#{title}&maxResults=5")
    results = JSON.parse(response.body)
    searched_books = results["items"]
    if searched_books
      books_array = []
      searched_books.each do |book|
        new_title = book["volumeInfo"]["title"]
        new_authors = book["volumeInfo"]["authors"]
        new_publisher = book["volumeInfo"]["publisher"]
        books_array << Book.new(title: new_title, author: new_authors, publisher: new_publisher)
      end
      display_books(books_array)
    else
      puts "no matches..."
    end
  end

  def display_books(books)
    books.each_with_index do |book, index|
      puts "        Book ##{index + 1}        "
      puts "Title: #{book.title}"
      puts "Author(s): #{book.author}"
      puts "Publisher: #{book.publisher}"
      puts
    end
  end
end