require 'pry'

class ApiManager

    BASE_URL = "https://opentdb.com/api.php?amount=10"

    def initialize
        @response = nil
    end

    def get_questions
        token = HTTParty.get("https://opentdb.com/api_token.php?command=request")
        @response = HTTParty.get("#{BASE_URL}10&token=#{token["token"]}")
        binding.pry
    end

end

api = ApiManager.new
questions = api.get_questions