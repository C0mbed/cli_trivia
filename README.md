# CliTrivia

The best Command Line Trivia app on the internet!  A quick one player game of Trivia pitting each user against the best of the Open Trivia Database.  

CLI Trivia makes use of 'HTTParty' to retrieve category and question JSON data from the [Open Trivia Database API](https://opentdb.com/api_config.php).  Upon initialize, CLI Trivia generates a token to prevent duplicate questions from appearing, and creates a Category class Object for each trivia category.  The user is then offered the choice between 10 questions: either randomly selected from a specific category.  CLI Trivia then displays the questions text, answer choices, and requests user input as to which answer they wish to select.  User score is calculated and displayed.  

IF the user selects 'random', CLI Trivia randomly generates 10 questions and creates Question class Objects.  If the user selects 'category' the user is presented with a list of possible trivia categories.  Upon selected, CLI Trivia makes an API call to retrieve 10 questions based on the user selected Category ID.  

Once all 10 questions are answered, the User is presented with a summary screen and the chance to exit or begin again.  

## Installation
Clone this repo to the directory of your choice!

## Run this Gem
In your terminal, run `bin/cli_trivia` from within the `cli_trivia` directory to begin!

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/<github username>/cli_trivia. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/<github username>/cli_trivia/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CliTrivia project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/<github username>/cli_trivia/blob/master/CODE_OF_CONDUCT.md).
