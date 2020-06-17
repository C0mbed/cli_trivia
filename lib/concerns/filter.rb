module CliTrivia::Filter

  # A method available to all classes that passes in a string and replaces unreadable characters with escaped
  # punctuation.  Used by question text and answers.
  def format_string(fs)
    fs = fs.gsub(/&quot;|&#039;/, "'")
    fs = fs.gsub(/&amp;/, "&")
    fs = fs.gsub(/&ograve;/, "o")
    fs = fs.gsub(/&atilde;/, "a")
    fs
  end

end