require 'pry'
# Cli class is a controller for the app and handles the display of all information and interactions with the user.
class Cli

  # Generates the categories, but not the questions on initialization and resets the @right and @wrong counters.  Finally
  # invokes call to begin the app.
  def initialize
    ApiManager.generate_categories
    @right = 0
    @wrong = 0
    call
  end

  def call
    system('clear')
    user_input = nil
    @right = 0
    @wrong = 0
    until user_input == 3 do
      system('clear')
      puts('----------------------------------------------------------------------------------')
      puts('----------------------------------------------------------------------------------')
      puts('')
      puts('                      Welcome to Command Line Trivia!!')
      puts('')
      puts('----------------------------------------------------------------------------------')
      puts('')
      puts('Would you prefer to have random questions, or do you want to select a category?')
      puts('')
      puts('----------------------------------------------------------------------------------')
      puts('----------------------------------------------------------------------------------')
      puts('')
      puts(' 1. random, 2. category, or 3. exit')
      puts('')
      puts('----------------------------------------------------------------------------------')
      puts('')
      puts('')
      user_input = gets.strip.to_i

      case user_input
      when 1
        generate_random
      when 2
        display_categories
      when 3
        system(exit)
        system('clear')
      when 'exit'
        system(exit)
      end
    end
  end

  def generate_random
    system('clear')
    ApiManager.generate_random_questions
    ApiManager.create_question
    Question.all.each do |question|
      display_question(question)
    end
    display_result
  end

  def display_categories
    system('clear')
    categories = Category.all_by_name
    count = 1
    puts('----------------------------------------------------------------------------------')
    puts('----------------------------------------------------------------------------------')
    puts('')
    puts('                      Welcome to Command Line Trivia!!')
    puts('')
    puts('----------------------------------------------------------------------------------')
    puts('')
    categories.each do |category|
      puts("#{count}. #{category.name}")
      count += 1
    end
    puts('')
    puts('----------------------------------------------------------------------------------')
    puts('----------------------------------------------------------------------------------')
    puts('')
    puts('Please select a category:')
    puts('')
    puts('----------------------------------------------------------------------------------')
    puts('')
    user_input = gets.strip.to_i
    display_questions_by_category(user_input)
  end


  def display_questions_by_category(user_input)
    index = user_input - 1
    question_id = Category.all_by_name[index].id
    ApiManager.generate_questions_by_id(question_id)
    ApiManager.create_question
    category = Category.all.select {|q| q.id == question_id }
    category[0].questions.each do |question|
      display_question(question)
    end
    display_result
  end

  def generate_answers(correct, incorrect, type)
    if type == 'boolean'
      answers = {
        correct: Question.format_string(correct),
        incorrect: incorrect,
        choices: %w[True False]
      }
      answers
    elsif type == 'multiple'
      random_answers = []
      incorrect.each do |wrong|
        wrong = Question.format_string(wrong)
        random_answers << wrong
      end
      answers = {
        correct: Question.format_string(correct),
        choices: [correct] + random_answers
      }
      answers
      end
    end

  def display_question(question)
    system('clear')
    answer_choices = generate_answers(question.correct_answer, question.incorrect_answers, question.type)
    correct_answer_index = answer_choices[:choices].index(answer_choices[:correct])
    puts('----------------------------------------------------------------------------------')
    puts('----------------------------------------------------------------------------------')
    puts('')
    puts("COMMAND LINE TRIVIA                                       SCORE: #{@right} / QUESTION #{@right+@wrong+1}/10")
    puts('')
    puts('----------------------------------------------------------------------------------')
    puts(question.question)
    puts('----------------------------------------------------------------------------------')
    puts('')
    if answer_choices[:choices].length > 2
      count = 1
      random_answers = answer_choices[:choices].shuffle
      random_answers.each do |answer_choice|
        puts("#{count}.  #{answer_choice}")
        count += 1
      end
    else
      puts("1. #{answer_choices[:choices][0]}")
      puts("2. #{answer_choices[:choices][1]}")
    end
    puts('')
    puts('----------------------------------------------------------------------------------')
    puts('----------------------------------------------------------------------------------')
    puts('')
    user_input = gets.strip.to_i

    if user_input - 1 == correct_answer_index
      @right += 1
      puts('')
      puts "That's correct.  Press Any Enter to Continue."
      gets
    else
      @wrong += 1
      puts('')
      puts "WRONG! #{answer_choices[:choices][correct_answer_index]} was CORRECT.  Press Any Enter to Continue."
      gets
    end
  end

  def display_result
    system('clear')
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts("COMPLETE!")
    puts('----------------------------------------------------')
    puts('')
    puts("YOU GOT #{@right} RIGHT, AND #{@wrong} WRONG!")
    puts('----------------------------------------------------')
    puts('')
    puts('')
    puts('press enter to return to the main menu')
    gets
    @right = 0
    @wrong = 0
    Question.clear_all
    call
  end
end