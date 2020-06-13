class Cli

  def initialize
    @generated_questions = ApiManager.generate_questions
    ApiManager.create_question

  end

  def call
    user_input = ""
    until user_input == "exit" do
      puts('Welcome to Command Line Trivia!!')
      puts('To start trivia, please choose a category')
      puts('To exit, type exit')
      puts('----------------------------------------------------')
      puts('Categories:')
      puts('----------------------------------------------------')
      puts('----------------------------------------------------')
      user_input = gets.chomp

    end
  end
end