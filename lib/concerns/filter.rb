module CliTrivia::Filter

  # A method available to all classes that passes in a string and replaces unreadable characters with escaped
  # punctuation.  Used by question text and answers.
  def format_string(fsg)
    fsg = fsg.gsub(/&quot;/, "'")
    fsg = fsg.gsub(/&amp;/, '&')
    fsg = fsg.gsub(/&ograve;/, 'o')
    fsg = fsg.gsub(/&ouml;/, 'o')
    fsg = fsg.gsub(/&oacute;/, 'o')
    fsg = fsg.gsub(/&atilde;/, 'a')
    fsg = fsg.gsub(/&uuml;/, 'u')
    fsg = fsg.gsub(/&Ouml;/, 'O')
    fsg = fsg.gsub(/&prime;/, "'")
    fsg = fsg.gsub(/&Prime;/, '"')
    fsg = fsg.gsub(/&iacute;/, 'i')
    fsg = fsg.gsub(/&aacute;/, 'a')
    fsg = fsg.gsub(/&eacute;/, 'e')
    fsg = fsg.gsub(/&#039;/, "'")
    fsg = fsg.gsub(/&ldquo;/, '"')
    fsg = fsg.gsub(/&rdquo;/, '"')
    fsg = fsg.gsub(/&rsquo;/, "'")
    fsg = fsg.gsub(/&lsquo;/, "'")
    fsg = fsg.gsub(/&ntilde;/, 'n')
    fsg = fsg.gsub(/&lrm;/, '')
    fsg
  end
end