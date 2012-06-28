require "rubygems"
require "bundler/setup"
require 'multi_json'
require 'oj'
require 'bundler'
require 'ostruct'
require 'csv'
require 'json'
require "highline/import"
require_relative 'monkey_patches'

file = File.open('exports/ASN-CC-correct parents.json', "r").read
standards = MultiJson.load(file)

parent_code = ask "Parent dot notation:"
asn_parent  = ask "ASN Parent:"
grade_level = ask "Grade Level:"

parent_standard = standards.find({"ccssiSimplifiedDotNotation" => parent_code}, {}).first
to_change = standards.find({"asnParent" => asn_parent, "gradeLevels" => grade_level})
to_change.each do |standard|
  index = standards.index(standard)
  standard["ccsiParent"] = parent_standard["id"]
  standards[index] = standard
end

File.open('exports/ASN-CC-correct parents.json', "w+").write(MultiJson.encode(standards, :pretty => true))
