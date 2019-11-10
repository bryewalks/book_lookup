class Book
  attr_accessor :title, :author

  def initialize(input_options)
    @title = input_options[:title] || 'Unknown'
    @author = input_options[:author] || 'Unknown'
  end
end