require 'pry'

class Cli

  def initialize
    @generated_questions = ApiManager.generate_questions
    ApiManager.create_categories(@generated_questions)
    ApiManager.create_question(@generated_questions)
    @right = 0
    @wrong = 0
  end

  def call
    system('clear')
    @right = 0
    @wrong = 0
    puts('----------------------------------------------------')
    puts('Welcome to Command Line Trivia!!')
    puts('Would you prefer to have random questions, or do you want to select a category?')
    puts('----------------------------------------------------')
    puts('Your choice:')
    puts('----------------------------------------------------')
    puts(' 1. random, 2. category, or type exit')
    puts('')
    user_input = gets.strip.to_i

    case user_input
      when 1
        generate_random
      when 2
        display_categories
      when 3
        system(exit)
      when 'exit'
        system(exit)
    end
  end

  def generate_random
    system('clear')
    count = 3
    used_questions = []
    while count.positive?
      question = Question.all.sample
      display_question(question) unless used_questions.include?(question)
      used_questions << question
      count -= 1
    end
    display_result
  end

  def display_categories
    system('clear')
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts('Please select a category:')
    puts('----------------------------------------------------')
    categories = Category.all_by_name
    count = 1
    categories.each do |category|
      puts("#{count}. #{category.name}")
      count += 1
    end
    user_input = gets.strip.to_i
    display_questions_by_category(user_input)
  end

  def display_questions_by_category(user_input)
    index = user_input - 1
    category = Category.all[index]
    display_question(category.questions[0])
    display_result
  end

  def display_result
    system("clear")
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts("CONGRATULATIONS!  YOU GOT #{@right} RIGHT, AND #{@wrong} WRONG!")
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts('press enter to return to the main menu')
    gets
    call
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
    system('clear')
    answer_choices = generate_answers(random_questions.correct_answer, random_questions.incorrect_answers)
    correct_answer_index = answer_choices[:random_choices].index(random_questions.correct_answer)
    puts('----------------------------------------------------')
    puts("You have #{@right} correct, and #{@wrong} wrong answers.")
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts(random_questions.question)
    puts('----------------------------------------------------')
    puts("1. #{answer_choices[:random_choices][0]}")
    puts("2. #{answer_choices[:random_choices][1]}")
    puts("3. #{answer_choices[:random_choices][2]}")
    puts("4. #{answer_choices[:random_choices][3]}")
    puts('----------------------------------------------------')
    user_input = gets.strip.to_i

    if user_input == correct_answer_index + 1
      @right += 1
      puts "That's correct.  Press Any Enter to Continue."
      gets

    else
      @wrong += 1
      puts "WRONG! #{answer_choices[:random_choices][correct_answer_index]} was the correct answer.  Press Any Enter to Continue."
      gets

    end
    end

end