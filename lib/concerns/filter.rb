module CliTrivia::Filter

  # A method available to all classes that passes in a string and replaces unreadable characters with escaped
  # punctuation.  Used by question text and answers.
  def format_string(fsg)
    fsg = fsg.gsub(/&quot;|&#039;/, "'")
    fsg = fsg.gsub(/&amp;/, '&')
    fsg = fsg.gsub(/&ograve;|&ouml;|&oacute;/, 'o')
    fsg = fsg.gsub(/&atilde;/, 'a')
    fsg = fsg.gsub(/&uuml;/, 'u')
    fsg = fsg.gsub(/&Ouml;/, 'O')
    fsg = fsg.gsub(/&prime;/, "'")
    fsg = fsg.gsub(/&Prime;/, '"')
    fsg = fsg.gsub(/&iacute;/, 'i')
    fsg = fsg.gsub(/&aacute;/, 'a' )
    fsg
  end
end