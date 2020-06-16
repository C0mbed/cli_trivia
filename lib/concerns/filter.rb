module CliTrivia::Filter

  # A method available to all classes that passes in a string and replaces unreadable characters with escaped
  # punctuation.  Used by question text and answers.
  def format_string(question_string)
    formatted_string = question_string.gsub(/&quot;|&#039;/, "\'")
    formatted_string.gsub(/&amp;/, "\&")
  end

end