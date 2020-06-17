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
    user_input = nil
    until user_input == 3 do
      greeting = 'Welcome to COMMAND LINE TRIVIA!'
      main_text = 'Would you prefer to have random questions, or do you want to select a category?'
      selection_text = '1 Random, 2 Category, or 3 EXIT'
      user_input = display(greeting, main_text, selection_text)
      case user_input
        when 1
          generate_random
        when 2
          display_categories
        when 3
          system('clear')
          system(exit)
      end
    end
  end

  def display(header = "", title_text = "", body_text = "", footer_text = "" )
    system('clear')
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts("#{header}")
    puts('----------------------------------------------------')
    puts('')
    puts('')
    puts("#{title_text}")
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts("#{body_text}")
    puts('----------------------------------------------------')
    puts('')
    user_input = gets.strip.to_i
    puts('')
    puts('----------------------------------------------------')
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
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts('Please select a category:')
    puts('----------------------------------------------------')
    puts('')
    puts('')
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
    question_id = Category.all_by_name[index].id
    ApiManager.generate_questions_by_id(question_id)
    ApiManager.create_question
    category = Category.all.select {|q| q.id == question_id }
    category[0].questions.each do |question|
      display_question(question)
    end
    display_result
  end

  def generate_answers(correct, incorrect)
    correct = Question.format_string(correct)
    random_answers = [correct]
    answer_choices = {
      correct: correct,
      random_choices: []
    }
    incorrect.each do |wrong|
      wrong = Question.format_string(wrong)
      random_answers << wrong
    end
    answer_choices[:random_choices] = random_answers.shuffle
    answer_choices
  end

  def display_question(question)
    system('clear')
    answer_choices = generate_answers(question.correct_answer, question.incorrect_answers)
    correct_answer_index = answer_choices[:random_choices].index(question.correct_answer) || 1
    puts('----------------------------------------------------')
    puts('----------------------------------------------------')
    puts("SCORE: #{@right}/10")
    puts('----------------------------------------------------')
    puts(question.question)
    puts('----------------------------------------------------')
    puts('')
    puts('')
    puts("1. #{answer_choices[:random_choices][0]}")
    puts("2. #{answer_choices[:random_choices][1]}")
    puts("3. #{answer_choices[:random_choices][2]}")
    puts("4. #{answer_choices[:random_choices][3]}")
    puts('----------------------------------------------------')
    user_input = gets.strip.to_i

    if user_input - 1 == correct_answer_index
      @right += 1
      puts('')
      puts "That's correct.  Press Any Enter to Continue."
      gets
    else
      @wrong += 1
      puts('')
      puts "WRONG! #{answer_choices[:random_choices][correct_answer_index]} was the correct answer.  Press Any Enter to Continue."
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