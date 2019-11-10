class Book
  attr_accessor :title, :author, :publisher

  def initialize(input_options)
    @title = input_options[:title] || 'Unknown'
    @author = input_options[:author] || 'Unknown'
    @publisher = input_options[:publisher] || 'Unknown'
  end
end