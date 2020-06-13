require 'pry'

# This is a question object. A hash of question data is passed in on creation from ApiManager.  It is then stored and converted for use in CLI.
class Question
  attr_accessor :category, :type, :difficulty, :question, :correct_answer, :incorrect_answers

  @@all = []

  def initialize(question_data)
    @category = question_data['category']
    @type = question_data['type']
    @difficulty = question_data['difficulty']
    @question = question_data['question']
    @correct_answer = question_data['correct_answer']
    @incorrect_answer = question_data['incorrect_answer']
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset_all
    @@all.clear
  end
end