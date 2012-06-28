require "rubygems"
require "bundler/setup"
require 'multi_json'
require 'oj'
require 'bundler'
require 'ostruct'
require_relative 'monkey_patches'


guids = MultiJson.load(File.open('exports/cc-guids-munged.json', "r").read)

root_guids = guids.find({"dot_notation" => /Math\.\w{1,}\z/ })

output = []
root_guids.each do |guid|
	guid["id"] = guid.delete("GUID")
	guid["ccssiSimplifiedDotNotation"] = guid.delete("simplified_dot_notation")
	guid["ccssiURI"] = guid.delete("URI")
	guid["language"] = "English"
	guid["authorityStatus"] = "Original Statement"
	guid["indexingStatus"] = "Yes"
	guid["subject"] = "Math"
	guid["cls"] = "folder"
	guid["dot_notation"].gsub(/Math\.(\w+)/){ guid["listIdentifier"] = $1}
	guid["ccssiDotNotation"] = guid.delete("dot_notation")
	guid["jurisdiction"] = "Common Core State Standards Initiative"
	guid["jurisdictionAbbreviation"] = "CC"
	output << guid
end


File.open('exports/root-guids.json', "w+").write(MultiJson.encode(output, :pretty => true))

