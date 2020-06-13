class Category
  attr_accessor :name, :questions
  extend CliTrivia::Findable

  @@all = []

  def initialize(name)
    @name = name
    @questions = []
  end

  def self.all
    @@all
  end

  def self.all_by_name
    @@all.sort! {|a, b|  a.name <=> b.name}
  end

  def save
    @@all << self
  end

  def self.create(name)
    category = new(name)
    category.save
    category
  end

  def add_question(question)
    @questions << question unless question == nil || @questions.include?(question)
  end

  def self.clear_all
    @@all.clear
  end
end
