class Book
  attr_accessor :title, :publisher, :authors

  def initialize(input_options)
    @title = input_options[:title] || 'Unknown'
    @authors = input_options[:authors] || ['Unknown']
    @publisher = input_options[:publisher] || 'Unknown'
  end

  def format_authors
    if @authors.length == 1
      @authors[0]
    else @authors.length > 1
      @authors.join(', ')
    end
  end
end