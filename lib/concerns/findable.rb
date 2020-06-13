module CliTrivia::Findable

  def find_by_name(name)
    all.find {|a| a.name == name}
  end

  def find_or_create_by_name(name)
    found = find_by_name(name)
    if found == nil
      create(name)
   else
     found
   end
  end
end