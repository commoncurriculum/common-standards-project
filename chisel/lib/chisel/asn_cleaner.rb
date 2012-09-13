module ASNCleaner
  
  def clean
    remove_asn_prefix
    remove_asn_urls
    capitalize_subjects
  end
  


  private 

  def remove_asn_prefix
    file.gsub!(/dcterms_/, "")
    file.gsub!(/asn_/, "")
    self
  end

  def capitalize_subjects
    file.gsub!(/"math"/, "\"Math\"")
    self
  end   

  def remove_asn_urls
    file.gsub!("http:\\/\\/purl.org\\/dc\\/terms\\/", "")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/scheme\\/ASNEducationLevel\\/","")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/schema\\/core\\/","")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/scheme\\/ASNIndexingStatus\\/", "")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/scheme\\/ASNAuthorityStatus\\/", "")
    file.gsub!("http:\\/\\/asn.jesandco.org\\/resources\\/", "")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/scheme\\/ASNTopic\\/", "")
    file.gsub!("http:\\/\\/id.loc.gov\\/vocabulary\\/iso639-2\\/", "")
    file.gsub!("http:\\/\\/www.w3.org\\/1999\\/02\\/22-rdf-syntax-ns#/", "")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/scheme\\/ASNAuthorityStatus\\/", "")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/scheme\\/ASNTopic\\/", "")
    file.gsub!("http:\\/\\/purl.org\\/gem\\/qualifiers\\/", "")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/resources\\/", "")
    file.gsub!("http:\\/\\/xmlns.com\\/foaf\\/0.1\\/", "")
    file.gsub!("http:\\/\\/purl.org\\/dc\\/elements\\/1.1\\/", "")
    file.gsub!("http:\\/\\/creativecommons.org\\/ns#/", "")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/scheme\\/ASNJurisdiction\\/", "")
    file.gsub!("http:\\/\\/purl.org\\/dc\\/elements\\/1.1\\/", "")
    file.gsub!("http:\\/\\/purl.org\\/ASN\\/scheme\\/ASNPublicationStatus/", "")
    self
  end
end
