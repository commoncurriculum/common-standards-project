require "rubygems"
require "bundler/setup"
require "multi_json"
require "oj"
require 'pry'
require 'ostruct'
require 'csv'

require_relative 'chisel/asn_manifest'
require_relative 'chisel/ccssi_identifier'
require_relative 'chisel/converter'
require_relative 'chisel/conversions'


asn_reading = ASNManifest.new('raw-data/ASN/manifest/CC-reading.json')

identifiers_v1 = CCSSIIdentifier.new('raw-data/CCSSI/CCSSI-identifiers-v1.json')
identifiers_v2 = CCSSIIdentifier.new('raw-data/CCSSI/CCSSI-identifiers-v2.json')
CCSSIIdentifier.combine_v1_with_v2(identifiers_v1.doc, identifiers_v2.doc)

asn_reading.clean
           .flatten
           .nest
           .munge
           .assign_guids(identifiers_v2.doc)
           .organize


#################################
#
# Check for missing standards
#
##################################
           
# Litaracy

asn_ids = asn_reading.doc.collect{|s| s['id']}
asn_ids.uniq!

literacy_ids = identifiers_v2.literacy.collect{|s| s['GUID']}
literacy_ids.uniq!
diff = literacy_ids - asn_ids
#missing_standards = identifiers_v2.literacy.collect do |id|
    #next unless diff.find{|s| s == id['GUID']}
    #id
#end.compact!
puts diff.count

# Math


#math_ids = identifiers_v2.math.collect{|s| s['GUID']}
#math_ids.uniq!
#diff = math_ids - asn_ids

#puts diff.count

#####################################
#
# Write file
#
# ##################################
#

f = File.open('clean-data/CC/literacy/literacy-0.8.0.json', 'w+')
f.write(MultiJson.encode(asn_reading.doc, :pretty => true))
f.close
