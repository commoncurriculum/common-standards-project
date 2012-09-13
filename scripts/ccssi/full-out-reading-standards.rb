require "rubygems"
require "bundler/setup"
require 'multi_json'
require 'oj'
require 'bundler'
require 'ostruct'
require 'csv'
require 'json'
#require "highline/import"
require_relative '../monkey_patches'
#require_relative '../conversions.rb'



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




ccssi = MultiJson.load(File.open('/Users/ScottMessinger/code/commoncurriculum/standards-data/raw-data/CCSSI/CCSSI-guids-dot-notations.json', "r+").read)
reading = ccssi.find("dot_notation" => /Literacy/)
output = []

reading.each do |read|
  read_output = {}
  ro = read_output
  ro["id"] = read.GUID
  ro["code"] = read.dot_notation
  #ro["shortCode"] = read.


  read["dot_notation"].match(/Literacy\.\w{1,2}\.([A-Z]|\d{1,4})/){ puts $1}
  #puts match
  #ro["gradeLevel"] = grades[match] unless match.nil?
  #ro["gradelevels"] = grades_to_grade_level[ro["gradeLevel"]]
  

  ro["CCSSI"] = {}
  ccssi = ro["CCSSI"]
  ccssi["GUID"] = read.GUID
  ccssi["dotNotation"] = read.dot_notation
  ccssi["URI"] = read.URI
  ccssi["currentURL"] = read.current_url
  

  output << ro
end


#puts output

