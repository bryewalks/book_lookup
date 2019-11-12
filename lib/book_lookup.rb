require 'http'
require_relative 'book'

class BookLookup
  def initialize
    @reading_list = []
    @max_results = 5
  end

  def run_program
    option = nil
    until option == 3
      system("clear")
      display_options
      option = user_input.to_i
      case option
      when 1
        search_path
      when 2
        reading_list_path
      when 3
        puts 'Good-bye'
      else
        puts 'Not a valid option'
        sleep(0.5)
      end
    end
  end

  def reading_list_path
    if @reading_list.any?
      display_books(@reading_list)
    else
      puts "You have no books in your reading list!"
    end
    puts 'Press enter to return'
    gets
  end

  def search_path
    searching = true
    while searching
      system("clear")
      puts "enter book title to search for books"
      title = user_input
      search_books(title)
      if @found_books.any? && add_to_saved?
        select_book
      end
      searching = search_again?
    end
  end

  def select_book
    selecting = true
    while selecting
      puts "Enter book # to add to reading list"
      until (book_number = user_input.to_i).between?(1, @max_results)
        puts "Please enter valid book number."
      end
      add_book(book_number)
      selecting = add_another?
    end
  end

  def add_book(number)
    @reading_list << @found_books[number - 1]
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

  def add_another?
    puts "Add another? y/n"
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
    response = HTTP.get("https://www.googleapis.com/books/v1/volumes?q=#{title}&maxResults=#{@max_results}")
    results = JSON.parse(response.body)
    searched_books = results["items"]
    @found_books = []
    if searched_books
      searched_books.each do |book|
        new_title = book["volumeInfo"]["title"]
        new_authors = book["volumeInfo"]["authors"]
        new_publisher = book["volumeInfo"]["publisher"]
        @found_books << Book.new(title: new_title, authors: new_authors, publisher: new_publisher)
      end
      display_books(@found_books)
    else
      puts "no matches..."
    end
  end

  def display_books(books)
    books.each_with_index do |book, index|
      puts "        Book ##{index + 1}        "
      puts "Title: #{book.title}"
      puts "Author(s): #{book.format_authors}"
      puts "Publisher: #{book.publisher}"
      puts
    end
  end
end