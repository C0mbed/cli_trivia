# Cli class is a controller for the app and handles the display of all information and interactions with the user.
class Cli

  # Generates the categories, but not the questions on initialization and resets the @right and @wrong counters.  Finally
  # invokes call to begin the app.
  def initialize
    ApiManager.generate_categories
    @right = 0
    @wrong = 0
    @correct_index = nil
    @prompt = TTY::Prompt.new
  end

  def call
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
      user_input = @prompt.select("Choose either random, or select a category?", %w(Random Category Exit))
      puts('')
      puts('----------------------------------------------------------------------------------')
      puts('')
      puts('')

      case user_input
      when "Random"
        generate_random
      when "Category"
        display_categories
      when "Exit"
        system('clear')
        system(exit)
      end
    end
  end

  def generate_random
    ApiManager.generate_random_questions
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

  def display_answer_choices(question, answer_choices, random_answers)
    if answer_choices[:choices].length > 2
      user_input = @prompt.select("#{question.question}", random_answers)
      user_input
    else
      user_input = @prompt.select("#{question.question}", answer_choices[:choices])
      user_input
    end
  end

  def question_type(answer_choices)
    if answer_choices[:choices].length > 2
      random_answers = answer_choices[:choices].shuffle
      @correct_index = random_answers.index(answer_choices[:correct])
      random_answers
    else
      random_answers = answer_choices[:choices]
      @correct_index = random_answers.index(answer_choices[:correct])
      random_answers
    end
  end

  def correct?(user_input, random_answers)
    user_input == random_answers[@correct_index]
  end

  def display_question(question)
    system('clear')
    answer_choices = generate_answers(question.correct_answer, question.incorrect_answers, question.type)
    random_answers = question_type(answer_choices)
    puts('----------------------------------------------------------------------------------')
    puts('')
    puts("COMMAND LINE TRIVIA                                       SCORE: #{@right} / QUESTION #{@right+@wrong+1}/10")
    puts('')
    puts('----------------------------------------------------------------------------------')
    puts('')
    user_input = display_answer_choices(question, answer_choices, random_answers)
    puts('')
    puts('----------------------------------------------------------------------------------')
    puts('')
    if correct?(user_input, random_answers)
      @right += 1
      puts "That's correct.  Press Any Enter to Continue."
      gets
    else
      @wrong += 1
      puts "WRONG! #{answer_choices[:correct]} was CORRECT.  Press Any Enter to Continue."
      gets
    end
  end

  def display_result
    system('clear')
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts('COMPLETE!')
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