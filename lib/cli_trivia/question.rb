require 'pry'

# This is a question object. A hash of question data is passed in on creation from ApiManager.  It is then stored and converted for use in CLI.
class Question
  attr_accessor :category, :type, :difficulty, :question, :correct_answer, :incorrect_answers

  @@all = []

  def initialize
    @@all << self
  end

  def self.reset_all
    @@all.clear
  end

  def self.create_from_response(question)
    @category = question['category']
    @type = question['type']
    @difficulty = question['difficulty']
    @question = question['question']
    @correct_answer = question['correct_answer']
    @incorrect_answer = question['incorrect_answer']
  end
end