require_relative 'asn_cleaner'
require_relative 'asn_flattener'
require_relative 'asn_munger'
require_relative 'asn_organizer'

class ASNManifest
  include ASNCleaner
  include ASNFlattener
  include ASNMunger
  include ASNOrganizer

  def initialize(file)
    @file = File.open(file, 'r+').read
  end

  def file
    @file
  end

  def doc=(doc)
    @doc = doc
  end

  def doc
    @doc ||=  MultiJson.decode(file)
  end


  def find_guid(code, guids)
    guids.find do |guid|
      guid["short_code_v1"] == code
    end
  end

  def assign_guids(guids)
    doc.each_with_index do |standard, i|
      guid = find_guid(standard["CCSS"]["simplifiedDotNotation"], guids)
      if guid.nil?
        #puts standard["id"]
      else
        doc[i]["id"]                    = guid["GUID"]
        doc[i]["CCSS"]["URI"]           = guid["URI"]
        doc[i]["CCSS"]["dotNotationV1"] = guid["dot_notation_v1"]
        doc[i]["CCSS"]["dotNotation"]   = guid["dot_notation"]
        doc[i]["CCSS"]["currentURL"]    = guid["current_url"]
      end
    end
    self
  end

  
end
