require "rubygems"
require "bundler/setup"
require 'multi_json'
require 'oj'
require 'bundler'
require 'ostruct'
require 'csv'
require 'json'
require "highline/import"


# CEDS Grade Levels
GRADE_LEVELS = {
"Infant/toddler"=>"IT",
"Preschool"=>"PR",
"Prekindergarten"=>"PK",
"Transitional Kindergarten"=>"TK",
"Kindergarten"=> "KG",
"First grade"=> "01",
"Second grade"=> "02",
"Third grade"=> "03",
"Fourth grade"=>"04",
"Fifth grade"=>"05",
"Sixth grade"=>"06",
"Seventh grade"=>"07",
"Eighth grade"=> "08",
"Ninth grade"=>"09",
"Tenth grade"=>"10",
"Eleventh grade"=> "11",
"Twelfth grade"=> "12",
"Grade 13"=>"13",
"Postsecondary"=>"PS",
"Adult education"=>"AE",
"Ungraded"=> "UG",
"Other"=>""
}

# Conversion of ASN to CEDS grade levels
ASN_TO_CEDS_LEVELS = {
"K"=> "KG",
"1"=> "01",
"2"=> "02",
"3"=> "03",
"4"=>"04",
"5"=>"05",
"6"=>"06",
"7"=>"07",
"8"=> "08",
"9" => "09",
"10" => "10",
"11" =>  "11",
"12"=> "12"
}


# lookup to convert to normal words
CC_GRADE_TO_WORDS = {
"K"=> "Kindergarten",
"1"=> "First Grade",
"2"=> "Second Grade",
"3"=> "Third Grade",
"4"=>"Fourth Grade",
"5"=>"Fifth Grade",
"6"=>"Sixth Grade",
"7"=>"Seventh Grade",
"8"=> "Eighth Grade",
"9" => "Ninth Grade",
"10" => "Tenth Grade",
"11" =>  "Eleventhh Grade",
"12"=> "Twelfth Grade"
}

# Make hashes easier to call
class Hash
  def method_missing(method, *opts)
    m = method.to_s
    if self.has_key?(m)
      return self[m]
    elsif self.has_key?(m.to_sym)
      return self[m.to_sym]
    end
    super
  end
end


asn = File.open('exports/ASN-CC-munged-manifest.json', "r").read
tree = MultiJson.load(asn)
flat = []
no_code = []
ccssi_guids = MultiJson.load(File.open('exports/cc-guids-munged.json', "r").read)

def push_children(container, element)
  if element.is_a?(Hash) && element.has_key?("children")
    element.children.each do |el|
      el[:asnParent] = element.id
      container << el 
        push_children(container, el)
      end
    end
    element.delete("children")
end


tree.each do |branch|
  flat << branch
  push_children(flat, branch)
end

flat.each_with_index do |hash, i|
  hash.each do |k, v|
    if v.is_a?(Hash) 

      # move prefLabel 
      # eg. move from 
      #
      # "authorityStatus": {
      #  "uri": "Original",
      #  "prefLabel": "Original Statement"
      # },
      #
      # to
      # "authorityStatus": "Original Statement"
      if v.has_key?("prefLabel")
        flat[i][k] = v["prefLabel"]
      end

      # move literal to value
      # from: 
      # "description": {
      #  "literal": "Standards for Mathematical Practice",
      #  "language": "en-US"
      # },
      # 
      # to:
      # "description" : "Standards for Mathematical Practice"
      #
      if v.has_key?("literal")
        flat[i][k] = v["literal"]
      end

    end
  end

  flat[i]["asnIdentifier"] = flat[i].delete("identifier")

  if flat[i].has_key?("comment") && flat[i].comment.class == Array
    flat[i].comment.collect!{ |el| el.literal }
  end


  # parse out number from standard
  num = ""
  text = ""
  flat[i].delete("text")
  if hash.has_key?("description")
      flat[i]["statement"] = flat[i].delete("description")
      if hash.statement.gsub(/^(\d|[a-zA-Z])\.\s(.+)/).count > 0
          hash.statement.gsub(/^(\d|[a-zA-Z])\.\s(.+)/) { num = $1; text = $2}
          flat[i]["listIdentifier"] = num
          flat[i]["statement"] = text
      end
  end

  # make sure all comments are an array and put in the clarification key
  if hash.has_key?("comment") && hash.comment.class == String
      #string = flat[i]["comment"]
      flat[i]["clarifications"] = [flat[i].delete("comment")]
  end

  if hash.has_key?("educationLevel") && hash.educationLevel.class == Array
    flat[i]["educationLevel"].collect!{ |el| el.prefLabel }
  end

  flat[i]["asnStatementNotation"] = flat[i].delete("statementNotation") unless !hash.has_key?("statementNotation")
  flat[i]["asnStatementNotation"] = flat[i].delete("statementNotation") unless !hash.has_key?("statementNotation")

  #change statement notation to match NGA/CCSSO notation
  if hash.has_key?("asnStatementNotation")
    code = hash.asnStatementNotation.clone
    if code.gsub(/(\d)\.([a-z])/).count > 0
      code.gsub!(/(\d)\.([a-z])/, $1 + $2)
    end
    flat[i]["ccssiSimplifiedDotNotation"] = code
  end
  
  flat[i]["gradeLevels"] = flat[i].delete("educationLevel") unless !hash.has_key?("educationLevel")


  #add fields about jurisdiction
  flat[i]["jurisdiction"] = "Common Core State Standards Initiative"
  flat[i]["jurisdictionAbbreviation"] = "CC"
  
  # convert grade levels to always be an array
  if hash.gradeLevels.class == String
      string = flat[i]["gradeLevels"]
      flat[i]["gradeLevels"] = [string]
  end

  # grade levels
  if hash.has_key?("gradeLevels")
      flat[i]["gradeLevels"].collect! do |value|
          ASN_TO_CEDS_LEVELS[value]
      end
  end
 
  # grab grade from standard
  if hash.has_key?("code")
      flat[i]["code"].gsub(/(\d+)\./) do 
          flat[i]["grade"] = CC_GRADE_TO_WORDS[$1]
      end
  end
   

  # pull out standards without codes
  if !hash.has_key?("ccssiSimplifiedDotNotation")
    code = ask "What is the ccssi sipmlified dot notation for #{hash.statement}?"
    flat[i]["ccssiSimplifiedDotNotation"] = code
  end

end

File.open('exports/ASN-CC-manipulated-munged.json', "w+").write(MultiJson.encode(flat, :pretty => true))
File.open('exports/standards-no-code.json', "w+").write(MultiJson.encode(no_code, :pretty => true))



class Array
	def find(*args)
		args.each do |arg|
			self.select! do |el|
				if el.is_a?(Array)
					el[arg.key].include?(arg.value)
				else
					el[arg.key] == arg.value
				end
			end
		end
	end
end
