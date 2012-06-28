require "rubygems"
require "bundler/setup"
require 'multi_json'
require 'oj'
require 'bundler'
require 'ostruct'

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

asn = File.open('exports/ASN-CC-munged.json', "r").read

hash = MultiJson.load(asn)

# turn the array into a normal looking hash
# e.g.
#  "educationLevel" : [
#      { "value" : "K", "type" : "uri" },
#      { "value" : "1", "type" : "uri" }
#   ]
#
# into
# "educationalLevel" : ["K", "1"]
hash.each do |k, v|
    v.each do |kk, vv|
        if vv.length > 1
            value = vv.collect{ |item| item.value}
        else
            value = vv[0].value
        end
        hash[k][kk] = value
    end
end

array = []

hash.each do |k, v|
    # rename identifier
    hash[k]["ASNidentifier"] = k
    hash[k].delete("identifier")
    hash[k]["code"] = hash[k].delete("statementNotation") unless !v.has_key?("statementNotation")
    hash[k]["gradeLevels"] = hash[k].delete("educationLevel") unless !v.has_key?("educationLevel")

    #add fields about jurisdiction
    hash[k]["jurisdiction"] = "Common Core State Standards Initiative"
    hash[k]["jurisdictionAbbreviation"] = "CC"


    # convert grade levels to always be an array
    if hash[k]["gradeLevels"].class == String
        string = hash[k]["gradeLevels"] 
        hash[k]["gradeLevels"]  = [string]
    end

    # convert ASN grade levels to CEDS grade levels
    if hash[k].has_key?("gradeLevels")
        hash[k]["gradeLevels"].collect! do |value|
            ASN_TO_CEDS_LEVELS[value]
        end
    end
   
    # grab grade from standard
    if hash[k].has_key?("code")
        hash[k]["code"].gsub(/(\d+)\./) do 
            hash[k]["grade"] = CC_GRADE_TO_WORDS[$1]
        end
    end

    # parse out number from standard
    num = ""
    text = ""
    if v.has_key?("description")
        if v.description.gsub(/(\d)\.\s(.+)/).count > 0
            v.description.gsub(/(\d)\.\s(.+)/) { num = $1; text = $2}
            hash[k]["description"] = text
            hash[k]["listIdentifier"] = num
        end
    end
    array << hash[k]
end


File.open('exports/ASN-CC-manipulated.json', "w+").write(MultiJson.encode(array, :pretty => true))




