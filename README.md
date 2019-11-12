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

After running run.rb user will be given 3 selections

1.Search Books
2.Reading List
3.Exit

When user selects 1: User will be asked for a book title to search. After each search the user will be asked if they would like to add selections to their reading list and if they would like to search again.

When user selects 2: Users current reading list will be displayed on screen. More books can be added to reading list at any time.

When user selects 3: Program will say good-bye and exit.

### Tests

Testing was done using rspec.

* [RSpec] (https://github.com/rspec/rspec) - Behaviour Driven Development for Ruby

  ```
  $ gem install rspec
  ```

  to run test

  ```
  $ rspec
  ```
  from root directory



