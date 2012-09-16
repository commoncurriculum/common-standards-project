module ASNMunger

  def munge
    doc.each_with_index do |standard, i|
      add_ccss_notations(doc[i])
      clean_comments(doc[i])
      remove_number_from_statement(doc[i])
      flatten_education_level(doc[i])
      rename_education_level(doc[i])
      change_statement_notation(doc[i])
      add_jurisdiction(doc[i])
      convert_grade_levels_to_ceds(doc[i])
      standards_without_codes(doc[i])
      add_grade_level(doc[i])
      convert_subjects(doc[i])
    end
    self
  end


  def add_ccss_notations(standard)
    file = File.open('raw-data/CCSSI/asn_to_ccss_notation.json', 'r').read
    doc = MultiJson.decode(file)
    found = doc.find do |d|
      d['asn_notation'] == standard['ASN']['statementNotation']
    end
    return if found.nil?
    found['ccss_notation'].gsub!(/CCSS.ELA-Literacy./, '')
    found['ccss_notation'].gsub!(/CCSS.Math.Content./, '')
    found['ccss_notation'].gsub!(/CCSS.Math.Practice./, '')
    standard['CCSS']['simplifiedDotNotation'] = found['ccss_notation']
  end



  def clean_comments(standard)
    if standard.has_key?("comment") && standard.class == Array
      standard['comment'].collect!{ |el| el.literal }
    end
  end


  # parse out number from standard
  def remove_number_from_statement(standard)
    return unless standard.has_key?("description")
    num = ""
    text = ""
    standard.delete("text")
    standard["statement"] = standard.delete("description")
    if standard['statement'].gsub(/^(\d|[a-zA-Z])\.\s(.+)/).count > 0
      standard['statement'].gsub(/^(\d|[a-zA-Z])\.\s(.+)/) { num = $1; text = $2}
      standard["listIdentifier"] = num
      standard["statement"] = text
    end
  end

  def flatten_education_level(standard)
    return unless standard.has_key?("educationLevel") && standard['educationLevel'].class == Array
    standard["educationLevel"].collect!{ |el| el['prefLabel'] }
  end


  def rename_education_level(standard)
    # and make sure they're always an array
    standard["gradeLevels"] = Array(standard.delete("educationLevel")) if standard.has_key?("educationLevel")
  end 

  # change statement notation to match NGA/CCSSO notation
  # e.g.: WHST.9-10.2.b => WHST.9-10.2b
  def change_statement_notation(standard)
    return if standard['ASN']['statementNotation'].nil?
    return unless standard['CCSS']['simplifiedDotNotation'].nil?
    
    code = standard["ASN"]['statementNotation'].clone
    if code.gsub(/(\d)\.([a-z])/).count > 0
      code.gsub!(/(\d)\.([a-z])/, $1 + $2)
    end
    standard["CCSS"]["simplifiedDotNotation"] = code
  end
  
  def add_jurisdiction(standard)
    #add fields about jurisdiction
    standard["jurisdiction"] = "Common Core State Standards Initiative"
    standard["jurisdictionAbbreviation"] = "CCSS"
  end
  
  def convert_grade_levels_to_ceds(standard)
    return unless standard.has_key?("gradeLevels")
    standard["gradeLevels"].collect! do |value|
        ASN_TO_CEDS_LEVELS[value]
    end
  end 

  def standards_without_codes(standard)
    # pull out standards without codes
    return if standard.has_key?("ccssiSimplifiedDotNotation")
    #code = ask "What is the ccssi sipmlified dot notation for #{hash.statement}?"
    #flat[i]["ccssiSimplifiedDotNotation"] = code
    #ret = standard
  end

  def add_grade_level(standard)
    standard["gradeLevel"] = GRADES[standard["gradeLevels"]]
  end

  def convert_subjects(standard)
    if standard["subject"] == "English"
      standard["subject"] = "Reading"
    end
  end
  
end
