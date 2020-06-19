# This is a question object. Question objects are created based on the user choice (either random or category).
# A JSON hash is returned from the openTDB GET request and stored in each question object.
class Question
  attr_accessor :category, :type, :difficulty, :question, :correct_answer, :incorrect_answers
  extend CliTrivia::Findable # allows for the searching of @@all by name and creating the object if one isn't found
  extend CliTrivia::Filter # filter to remove non-ASCII characters from strings.

  @@all = []

  # Because all metadata regarding a question is available on creation of each Question Object, it is populated upon
  # initialization and not after.
  def initialize(question_data)
    @category = add_category(question_data['category'])
    @type = question_data['type']
    @difficulty = question_data['difficulty']
    @question = Question.format_string(question_data['question'])
    @correct_answer = question_data['correct_answer']
    @incorrect_answers = question_data['incorrect_answers']
    @@all << self
  end

  # Allows for the adding of a Category Object to self.  A question BELONGS to a category.
  def add_category(name)
    category = Category.find_or_create_by_name(name)
    category.add_question(self)
  end

  def self.all
    @@all
  end

  def self.clear_all
    @@all.clear
  end
end