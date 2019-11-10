class Book
  attr_accessor :title

  def initialize(input_options)
    @title = input_options[:title] || "Unknown"
  end
end