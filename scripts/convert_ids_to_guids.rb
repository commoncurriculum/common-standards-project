require "rubygems"
require "bundler/setup"
require 'multi_json'
require 'oj'
require 'bundler'
require 'ostruct'
require_relative 'monkey_patches'

guids = MultiJson.load(File.open('exports/cc-guids-munged.json', "r").read)
standards = MultiJson.load(File.open('exports/ASN-CC-correct parents.json', "r").read)

standards.each_with_index do |standard, i|
  guid = guids.find("simplified_dot_notation" => standard["ccssiSimplifiedDotNotation"]).first
  if guid.nil?
    puts standard["id"]
  else
    standards[i]["id"] = guid["GUID"]
    standards[i]["ccssiURL"] = guid["URI"]
    standards[i]["ccssiDotNotation"] = guid["dot_notation"]
    standards[i]["ccssiCurrentUrl"] = guid["current_url"]
  end
end

File.open('exports/ASN-CC-converted-guids.json', "w+").write(MultiJson.encode(standards, :pretty => true))


