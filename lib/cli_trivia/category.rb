class Category
  attr_accessor :name, :questions, :id
  extend CliTrivia::Findable

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

  def self.all_by_name
    @@all.sort! {|a, b|  a.name <=> b.name}
  end

  def add_question(question)
    @questions << question unless question == nil || @questions.include?(question)
  end

  def self.clear_all
    @@all.clear
  end
end
