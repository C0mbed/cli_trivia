require 'pry'

class Cli

  def initialize
    @generated_questions = ApiManager.generate_questions
    ApiManager.create_categories(@generated_questions)
    ApiManager.create_question(@generated_questions)
  end

  def call
    user_input = ''
    until user_input == 'exit' do
      puts('----------------------------------------------------')
      puts('Welcome to Command Line Trivia!!')
      puts('Would you prefer to have random questions, or do you want to select a category?')
      puts('random, category, or exit')
      puts('----------------------------------------------------')
      puts('Your choice:')
      puts('----------------------------------------------------')
      puts('')
      user_input = gets.chomp

      case user_input
      when 'random'
        generate_random
      when 'category'
        #do something
      else
        puts("Please make a valid selection:")
      end
    end
  end

  def generate_random
    count = Question.all.length
    used_questions = []
    while count.positive?
      question = Question.all.sample
      display_question(question) unless used_questions.include?(question)
      used_questions << question
      count -= 1
    end
  end

  def generate_answers(correct, incorrect)
    random_answers = []
    answer_choices = {
      correct: correct,
      random_choices: []
    }
    incorrect.each do |wrong|
      random_answers << wrong
    end
    random_answers << correct
    answer_choices[:random_choices] = random_answers.shuffle
    answer_choices
  end

  def display_question(random_questions)
    answer_choices = generate_answers(random_questions.correct_answer, random_questions.incorrect_answers)
    puts('----------------------------------------------------')
    puts(random_questions.question)
    puts('----------------------------------------------------')
    puts("1. #{answer_choices[:random_choices][0]}")
    puts("2. #{answer_choices[:random_choices][1]}")
    puts("3. #{answer_choices[:random_choices][2]}")
    puts("4. #{answer_choices[:random_choices][3]}")
    puts('----------------------------------------------------')
    user_choice = gets.chomp

    case user_input
    when "#{answer_choices[0]}"
      puts("Wrong, try again!")
    when "#{answer_choices[1]}"
      #do something
    else
      puts("Please make a valid selection:")
    end
  end
end