# Cli class is a controller for the app and handles the display of all information and interactions with the user.
class Cli

  # Generates the categories, but not the questions on initialization and resets the @right and @wrong counters.  Finally
  # invokes call to begin the app.
  def initialize
    ApiManager.generate_categories
    @right = 0
    @wrong = 0
    @prompt = TTY::Prompt.new
  end

  # Begins the trivia game by printing the welcome, title, and asks user to make the first choice between random and
  # category.  Uses case to determine how to proceed from call.
  def call
    system('clear')
    puts('')
    puts('CLI Trivia')
    puts('')
    user_input = @prompt.select('Choose either random, or select a category?', %w[Random Category Exit])
    case user_input
    when 'Random'
      generate_random
    when 'Category'
      display_categories
    when 'Exit'
      system('clear')
      system(exit)
    end
  end

  # Run when user selects 'Random' from the main menu, calls on ApiManager class to query the api and create
  # Question Objects.  Finally, new question objects are displayed using display_question.
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
    puts('')
    puts('CLI Trivia')
    puts('')
    puts('')
    user_input = @prompt.select('Please Select a Category (scroll for more)', categories, per_page: 15)
    display_questions_by_category(user_input)
  end

  def display_questions_by_category(user_input)
    category = Category.find_by_name(user_input)
    question_id = category.id
    ApiManager.generate_questions_by_id(question_id)
    category.questions.each do |question|
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
        formatted_answer = Question.format_string(wrong)
        random_answers << formatted_answer
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
      @prompt.select("Q#{@right+@wrong+1}/10> #{question.question}", random_answers)
    else
      @prompt.select("Q#{@right+@wrong+1}/10> #{question.question}", answer_choices[:choices])
    end
  end

  def question_type(answer_choices)
    if answer_choices[:choices].length > 2
      random_answers = answer_choices[:choices].shuffle
    else
      random_answers = answer_choices[:choices]
    end
    random_answers
  end

  def correct?(user_input, correct_answer)
    user_input == correct_answer
  end

  def display_question(question)
    system('clear')
    answer_choices = generate_answers(question.correct_answer, question.incorrect_answers, question.type)
    random_answers = answer_choices[:choices]
    puts('')
    puts("CLI trivia :: #{@right} correct")
    puts('')
    user_input = display_answer_choices(question, answer_choices, random_answers)
    puts('')
    if correct?(user_input, answer_choices[:correct])
      @right += 1
      puts "That's correct.  Press Any Enter to Continue."
    else
      @wrong += 1
      puts "Wrong. #{answer_choices[:correct]} was right.  Enter to continue."
    end
    gets
  end

  def display_result
    system('clear')
    puts('')
    puts("CLI trivia :: Final score: #{@right}/10")
    puts('')
    user_input = @prompt.select('Exit or restart?', %w[Restart Exit])
    case user_input
    when 'Restart'
      Question.clear_all
      @right = 0
      @wrong = 0
      call
    when 'Exit'
      system('clear')
      system(exit)
    end
  end
end