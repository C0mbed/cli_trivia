require_relative '../lib/cli_trivia/version'
require 'pry'
require 'HTTParty'

require_relative '../lib/cli_trivia/apimanager'
require_relative '../lib/cli_trivia/question'
require_relative '../lib/cli_trivia/cli'


module CliTrivia
  class Error < StandardError; end
    # Your code goes here...
end