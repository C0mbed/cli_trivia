# frozen_string_literal: true

# Handles the external API call to the "Open Trivia Database" to get trivia question hashes
class ApiManager
  # base api url
  BASE_URL = 'https://opentdb.com/api.php?amount=10&token='

  def initialize
    @categories = nil
    @token = nil
  end

  def self.generate_token
    @token = HTTParty.get('https://opentdb.com/api_token.php?command=request10&token=')
    @token
  end

  def self.generate_categories
    @categories = HTTParty.get('https://opentdb.com/api_category.php')
    @categories['trivia_categories'].each do |category|
      Category.new(category['name'], category['id'])
    end
  end

  def self.generate_random_questions
    response = HTTParty.get("#{BASE_URL}#{@token}")
    create_questions(response)
  end

  def self.generate_questions_by_id(category_id)
    category_url = "&category=#{category_id}"
    response = HTTParty.get("#{BASE_URL}#{@token}#{category_url}")
    create_questions(response)
  end

  def self.create_questions(response)
    response['results'].each do |question|
      Question.new(question)
    end
  end
end
