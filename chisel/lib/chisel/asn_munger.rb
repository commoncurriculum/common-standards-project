module ASNMunger

  def munge
    doc.each_with_index do |standard, i|
      move_pref_label(doc[i])
      prefix_asn_fields(doc[i])
      clean_comments(doc[i])
      remove_number_from_standard(doc[i])
      flatten_education_level(doc[i])
      rename_education_level(doc[i])
      change_statement_notation(doc[i])
      add_jurisdiction(doc[i])
      convert_grade_levels_to_ceds(doc[i])
    end
  end

  def move_pref_label(standard)
    standard.each do |k, v|
      next unless v.is_a?(Hash) 
      # move prefLabel 
      # eg. move from 
      #
      # "authorityStatus": {
      #  "uri": "Original",
      #  "prefLabel": "Original Statement"
      # },
      #
      # to
      # "authorityStatus": "Original Statement"
      if v.has_key?("prefLabel")
        standard[k] = v["prefLabel"]
      end

      # move literal to value
      # from: 
      # "description": {
      #  "literal": "Standards for Mathematical Practice",
      #  "language": "en-US"
      # },
      # 
      # to:
      # "description" : "Standards for Mathematical Practice"
      #
      if v.has_key?("literal")
        standard[k] = v["literal"]
      end
    end
  end

  def prefix_asn_fields(standard)
    standard["asnIdentifier"] = standard.delete("identifier")
    standard["asnStatementNotation"] = standard.delete("statementNotation") if standard.has_key?("statementNotation")
    standard["asnStatementNotation"] = standard.delete("statementNotation") if standard.has_key?("statementNotation")
    
  end

  def clean_comments(standard)
    if standard.has_key?("comment") && standard.class == Array
      standard['comment'].collect!{ |el| el.literal }
    end
  end


  # parse out number from standard
  def remove_number_from_standard(standard)
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

  #change statement notation to match NGA/CCSSO notation
  def change_statement_notation(standard)
    return unless standard.has_key?("asnStatementNotation")
    code = standard['asnStatementNotation'].clone
    if code.gsub(/(\d)\.([a-z])/).count > 0
      code.gsub!(/(\d)\.([a-z])/, $1 + $2)
    end
    standard["ccssiSimplifiedDotNotation"] = code
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
end
