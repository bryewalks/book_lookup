# BookLookup

## Introduction 

This is a Ruby command line application to interact with the Google Books API. Some notable features:

* Search Google Books API.
* Create a list of books you want to read.

### Requirements 

This code has been run and tested on Ruby 2.5.3.


#### External Dependencies

* [http] (https://github.com/httprb/http) - a fast Ruby HTTP client with a chainable API, streaming support, and timeouts

### Installation & Run
   If using bundler
   ```
   $ bundle install
   ```
   otherwise
   ```
   $ gem install http
   ```

   then run
   ```
   $ ruby run.rb
   ```

### Usage

After running run.rb user will be given 3 options.

   1. Search Books

   2. Reading List

   3. Exit

To search select option one and enter a book title to search Google Books API. After each search you will be asked if you would like to add selections to your reading list.

To add items to reading list after a succesful search answer 'y' to add selections and then enter the book number to add to your reading list.

You can keep searching book titles and add as many to your reading list that you would like.

To view your reading list select option two.


### Tests

Testing was done using rspec and webmock. 

* [RSpec] (https://github.com/rspec/rspec) - Behaviour Driven Development for Ruby
* [WebMock] (https://github.com/bblimke/webmock) - Library for stubbing and setting expectations on HTTP requests in Ruby.

  ```
  $ gem install rspec
  ```
  ```
  $ gem install webmock
  ```

  to run test

  ```
  $ rspec
  ```
  from root directory



