require 'multi_json'
require 'oj'



asn = File.open('JSON-XML/ASN common core math flat.json', "r").read
asn.gsub!(/http:\/\/purl.org\/dc\/terms\//, "")
asn.gsub!(/http:\/\/purl.org\/ASN\/scheme\/ASNEducationLevel\//,"")
asn.gsub!(/http:\/\/purl.org\/ASN\/schema\/core\//,"")
asn.gsub!(/http:\/\/purl.org\/ASN\/scheme\/ASNIndexingStatus\//, "")
asn.gsub!(/http:\/\/purl.org\/ASN\/scheme\/ASNAuthorityStatus\//, "")
asn.gsub!(/http:\/\/asn.jesandco.org\/resources\//, "")
asn.gsub!(/http:\/\/purl.org\/ASN\/scheme\/ASNTopic\//, "")
asn.gsub!(/http:\/\/id.loc.gov\/vocabulary\/iso639-2\//, "")
asn.gsub!(/http:\/\/www.w3.org\/1999\/02\/22-rdf-syntax-ns#/, "")
asn.gsub!(/http:\/\/purl.org\/ASN\/scheme\/ASNAuthorityStatus\//, "")
asn.gsub!(/http:\/\/purl.org\/ASN\/scheme\/ASNTopic\//, "")
asn.gsub!(/http:\/\/purl.org\/gem\/qualifiers\//, "")
asn.gsub!(/http:\/\/purl.org\/ASN\/resources\//, "")
asn.gsub!(/http:\/\/xmlns.com\/foaf\/0.1\//, "")
asn.gsub!(/http:\/\/purl.org\/dc\/elements\/1.1\//, "")
asn.gsub!(/http:\/\/creativecommons.org\/ns#/, "")
asn.gsub!(/http:\/\/purl.org\/ASN\/scheme\/ASNJurisdiction\//, "")
asn.gsub!(/http:\/\/purl.org\/dc\/elements\/1.1\//, "")
asn.gsub!(/http:\/\/purl.org\/ASN\/scheme\/ASNPublicationStatus\//, "")
asn.gsub!(/"math"/, "\"Math\"")




File.open('exports/ASN-CC-munged.json', "w+").write(asn)


