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

asn_reading.clean.
            flatten.
            munge

puts MultiJson.encode(asn_reading.doc, :pretty => true)
#puts MultiJson.encode(identifiers_v1.doc, :pretty => true)
#puts MultiJson.encode(identifiers_v2.doc, :pretty => true)

