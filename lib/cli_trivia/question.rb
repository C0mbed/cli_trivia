require 'pry'

# This is a question object. A hash of question data is passed in on creation from ApiManager.  It is then stored and converted for use in CLI.
class Question
  attr_accessor :category, :type, :difficulty, :question, :correct_answer, :incorrect_answers
  extend  CliTrivia::Findable

  @@all = []

  def initialize(question_data)
    @category = add_category(question_data['category'])
    @type = question_data['type']
    @difficulty = question_data['difficulty']
    @question = format_string(question_data['question'])
    @correct_answer = question_data['correct_answer']
    @incorrect_answers = question_data['incorrect_answers']
    @@all << self
  end

  def format_string(question_string)
    formatted_string = question_string.gsub(/&quot;|&#039;/, "\'")
    return formatted_string.gsub(/&amp;/, "\&")
    binding.pry

  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def add_category(name)
    category = Category.find_or_create_by_name(name)
    category.add_question(self)
  end

  def self.reset_all
    @@all.clear
  end
end