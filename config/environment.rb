require_relative '../lib/cli_trivia/version'
require 'pry'
require 'httparty'

require_relative '../lib/concerns/filter'
require_relative '../lib/concerns/findable'
require_relative '../lib/cli_trivia/apimanager'
require_relative '../lib/cli_trivia/question'
require_relative '../lib/cli_trivia/cli'
require_relative '../lib/cli_trivia/category'


module CliTrivia
  class Error < StandardError; end
  # Your code goes here...
end
