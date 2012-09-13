class CCSSIIdentifier
  def initialize(file)
     @file = File.open(file, 'r+').read
  end

  def fix_spelling_errors
    file.gsub!(/wwwcorestandards\.org/, "www.corestandards.org")
    self
  end

  def underscore
    file.gsub!("Dot notation", "dot_notation")
    file.gsub!("Current URL", "current_url")
    self
  end

  def file
    @file
  end

  def file=(file)
    @file = file 
  end
end
