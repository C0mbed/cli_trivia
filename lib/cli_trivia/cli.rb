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
    until user_input == 'Exit' do
      system('clear')
      puts('')
      puts('CLI Trivia')
      puts('')
      user_input = @prompt.select("Choose either random, or select a category?", %w(Random Category Exit))

      case user_input
      when "Random"
        generate_random
      when "Category"
        display_categories
        #when "Exit"
        #system('clear')
        #system(exit)
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
    puts('')
    puts('CLI Trivia')
    puts('')
    puts('')
    user_input = @prompt.select("Please Select a Category", categories)
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
      user_input = @prompt.select("Q#{@right+@wrong+1}/10> #{question.question}", random_answers)
      user_input
    else
      user_input = @prompt.select("Q#{@right+@wrong+1}/10> #{question.question}", answer_choices[:choices])
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
    puts('')
    puts("CLI trivia                                                                                 #{@right} correct")
    puts('')
    user_input = display_answer_choices(question, answer_choices, random_answers)

    if correct?(user_input, random_answers)
      @right += 1
      puts('')
      puts "That's correct.  Press Any Enter to Continue."
      gets
    else
      @wrong += 1
      puts('')
      puts "WRONG! #{answer_choices[:correct]} was CORRECT.  Press Any Enter to Continue."
      gets
    end
  end

  def display_result
    system('clear')
    puts('')
    puts('Thanks for playing CLI trivia')
    puts("Final score: #{@right}/10")
    puts('')
    puts('')
    puts('')
    puts('press enter to return to the main menu')
    gets
    Question.clear_all
    @right = 0
    @wrong = 0
    call
  end
end