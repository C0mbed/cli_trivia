# Category Objects are created upon initializing the app using bin/cli_trivia.  This allows the user to choose between
# random and category. Each Category has MANY questions, but there is only one of every Category.
class Category
  attr_accessor :name, :questions, :id
  extend CliTrivia::Findable # allows for the searching of @@all by name and creating the object if one isn't found

  # Categories are stored in @@all and are accessed to print the list of user selectable categories.
  @@all = []

  def initialize(name, id)
    @id = id
    @name = name
    @questions = []
    @@all << self
  end

  def self.all
    @@all
  end

  # A modification of the self.all method to return all Categories alphabetically.  Used when categories are printed
  # for user choice.
  def self.all_by_name
    @@all.sort! {|a, b|  a.name <=> b.name}
  end
  
  # This stores questions that belong to this Category.  @questions is an instance variable available to this Category
  # Object only
  def add_question(question)
    @questions << question unless question.nil? || @questions.include?(question)
  end

  def self.clear_all
    @@all.clear
  end
end
