require "rubygems"
require "bundler/setup"
require 'multi_json'
require 'oj'
require 'bundler'
require 'ostruct'
require_relative 'monkey_patches'



standards = MultiJson.load(File.open('transition-data/cc-math/converted-guids.json', "r+").read)
output = []

grades = {
 "K" => "Kindergarten",
 "1" => "Grade 1",
 "2" => "Grade 2",
 "3" => "Grade 3",
 "4" => "Grade 4",
 "5" => "Grade 5",
 "6" => "Grade 6",
 "7" => "Grade 7",
 "8" => "Grade 8",
 "HS" => "High School",
 "MP" => "K-12"
}


grades_to_grade_level = {
 "Kindergarten" => ["K"],
 "Grade 1" => ["01"],
 "Grade 2" => ["02"],
 "Grade 3" => ["03"],
 "Grade 4" => ["04"],
 "Grade 5" => ["05"],
 "Grade 6" => ["06"],
 "Grade 7" => ["07"],
 "Grade 8" => ["08"],
 "High School" => ["09", "10", "11", "12"],
 "K-12" => ["K", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
}



standards.each do |standard|

  unless standard["ccssiDotNotation"].nil?
    match = standard["ccssiDotNotation"].match(/^Math\.([A-Z]{1,2}|\d)/)[1]
    standard["gradeLevel"] = grades[match] unless match.nil?
  end

  standard["code"] = standard["ccssiDotNotation"]
  standard["shortCode"] = standard.delete("ccssiSimplifiedDotNotation")

  unless standard["asnStatementNotation"].nil?
    standard["ASN"] = {}
    asn = standard["ASN"]
    asn["identifier"] = "http://purl.org/ASN/resources/" + standard["asnIdentifier"] unless standard["asnIdentifier"].nil?
    asn["id"] = standard.delete("asnIdentifier")
    asn["parent"] = standard.delete("asnParent") unless standard["asnParent"].nil?
    asn["indexingStatus"] = standard.delete("indexingStatus") 
    asn["authorityStatus"] = standard.delete("authorityStatus") 
    asn["statementNotation"] = standard.delete("asnStatementNotation") 
    asn["cls"] = standard.delete("cls") unless standard["cls"].nil?
    asn["leaf"] = standard.delete("leaf") unless standard["leaf"].nil?
  end

  unless standard["ccssiDotNotation"].nil?
    standard["CCSSI"] = {}
    ccssi = standard["CCSSI"]
    if !standard["ccssiDotNotation"].nil?
     ccssi["GUID"] = standard["id"]
    end
    ccssi["dotNotation"] = standard.delete("ccssiDotNotation")
    ccssi["URI"]  = standard.delete("ccssiURI")
    ccssi["currentURL"]  = standard.delete("ccssiCurrentUrl")
  end
  
  standard.delete("current_url")
  
  if standard["gradeLevels"].nil?
    standard["gradelevels"] = grades_to_grade_level[standard["gradeLevel"]]
  end


  output << standard
end


output_json = MultiJson.encode(output, :pretty => true)

File.open('clean-data/CC-math.json', "w+").write(output_json)

#
