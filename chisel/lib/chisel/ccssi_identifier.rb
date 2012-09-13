class CCSSIIdentifier
  def initialize(file)
     @file = File.open(file, 'r').read
     fix_spelling_errors
     underscore
     make_short_code
  end

  def fix_spelling_errors
    file.gsub!(/wwwcorestandards\.org/, "www.corestandards.org")
    self
  end

  def underscore
    file.gsub!("Dot notation", "dot_notation")
    file.gsub!("Current URL", "current_url")
    self
  end

  def make_short_code
    doc.each_with_index do |standard, i|
      doc[i]['short_code'] = standard['dot_notation'].gsub("CCSS.Math.Content.HS", "")
      doc[i]['short_code'] = doc[i]['short_code'].gsub("CCSS.Math.Content.", "")
      doc[i]['short_code'] = doc[i]['short_code'].gsub("CCSS.Math.Practice.", "")
      doc[i]['short_code'] = doc[i]['short_code'].gsub("CCSS.ELA-Literacy.", "")
    end
  end

  def file
    @file
  end

  def file=(file)
    @file = file 
  end

  def doc=(doc)
    @doc = doc
  end

  def doc
    @doc ||=  MultiJson.decode(file)
  end

  def self.combine_v1_with_v2(doc_1, doc_2)
    doc_2.each_with_index do |standard, i|
      doc_2[i]['dot_notation_v1'] = find_standard_by_guid(doc_1, standard['GUID'])['dot_notation']
      doc_2[i]['short_code_v1'] = doc_2[i]['dot_notation_v1'].clone
      doc_2[i]['short_code_v1'].gsub!("Math.HS", "")
      doc_2[i]['short_code_v1'].gsub!("Math.", "")
      doc_2[i]['short_code_v1'].gsub!("Literacy.", "")
    end
  end

  def self.find_standard_by_guid(doc, guid)
   doc.find do |standard|
      standard['GUID'] == guid
    end
  end
  
end
