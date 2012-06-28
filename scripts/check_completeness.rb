require "rubygems"
require "bundler/setup"
require 'multi_json'
require 'oj'
require 'bundler'
require 'ostruct'
require_relative 'monkey_patches'

standards = MultiJson.load(File.open('exports/ASN-CC-converted-guids.json', "r+").read)
guids = MultiJson.load(File.open('exports/cc-guids-munged.json', "r").read)
math_guids = guids.find("dot_notation" => /Math/)
not_found = []
output = []
c = 0
math_guids.each do |guid|
  found = standards.find("id" => guid["GUID"])
  if found.length == 1
    c += 1
  elsif found.length == 0
    not_found << guid
  else
  end
end

codes = {
 "CC" => "Counting and Cardinality",
 "OA" => "Operations and Algebraic Thinking",
 "NBT" => "Number and Operations in Base Ten",
 "MD" => "Measurement and Data",
 "G" => "Geometry",
 "NF" => "Number and Operations - Fractions",
 "RP" => "Ratios and Proportional Relationships",
 "NS" => "The Number System",
 "EE" => "Expressions and Equations",
 "SP" => "Statistics and Probability",
 "F"  => "Functions"
}


not_found.each do |guid|
  guid["id"] = guid.delete("GUID")
  guid["ccssiSimplifiedDotNotation"] = guid.delete("simplified_dot_notation")
  guid["ccssiURI"] = guid.delete("URI")
  guid["language"] = "English"
  guid["authorityStatus"] = "Original Statement"
  guid["indexingStatus"] = "Yes"
  guid["subject"] = "Math"
  guid["cls"] = "folder"
  # guid["dot_notation"].gsub(/Math\.(\w+)/){ guid["listIdentifier"] = $1}
  guid["ccssiDotNotation"] = guid.delete("dot_notation")
  guid["jurisdiction"] = "Common Core State Standards Initiative"
  guid["jurisdictionAbbreviation"] = "CC"
  code = ""
  guid["ccssiDotNotation"].gsub(/([a-zA-Z]{1,3})$/){ code = $1}
  guid["statement"] = codes[code]
  if guid["statement"].nil?
    # puts MultiJson.encode(guid, :pretty => true)
  else
    output << guid
  end
end

puts MultiJson.encode(output, :pretty => true)
# File.open('exports/root-guids.json', "w+").write(MultiJson.encode(output, :pretty => true))

puts "GUID COUNT: #{math_guids.length}"
puts "FOUND COUNT: #{c}"



