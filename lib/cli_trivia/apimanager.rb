require 'pry'

# Handles the external API call to the "Open Trivia Database" to get trivia question hashes
class ApiManager
  include HTTParty

  # base api url
  BASE_URL = 'https://opentdb.com/api.php?amount=10'.freeze

  def initialize
    @response = nil
  end

  def self.generate_questions
    token = HTTParty.get('https://opentdb.com/api_token.php?command=request')
    @response = HTTParty.get("#{BASE_URL}10&token=#{token['token']}")
    @response
  end

  def self.create_categories(questions)
    questions['results'].each do |question|
      Category.new(question['category'])
    end
  end

  def self.create_question(questions)
    questions['results'].each do |question|
      Question.new(question)
    end
  end



end
