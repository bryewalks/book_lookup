require 'http'
require_relative 'book'

class BookLookup

  def run_program
    system("clear")
    option = nil
    until option == 3
      display_options
      option = user_input
      case option
      when '1'
        puts 'search_path'
      when '2'
        puts 'reading_list_path'
      when '3'
        puts 'good bye'
      else
        puts 'not valid option'
      end
    end
  end

  def user_input
    gets.chomp
  end

  def continue?
    response = user_input.downcase
    response == 'y'
  end

  def add_to_saved?
    puts "Would you like to add selections to reading list? y/n"
    continue?
  end

  def search_again?
    puts "Search again? y/n"
    continue?
  end

  def display_options
    puts "1. Search Books"
    puts "2. Reading List"
    puts "3. Exit"
  end

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