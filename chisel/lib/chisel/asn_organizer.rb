module ASNOrganizer

  def nest
    doc.each_with_index do |standard, i|
      doc[i]["ASN"] = {}
      doc[i]["CCSS"] = {}
      move_pref_label(doc[i])
      nest_asn(doc[i])
    end
    self
  end

  def organize
    doc.each_with_index do |standard, i|
      add_grade_level(doc[i])
      rename_notations(doc[i])
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
  
  def nest_asn(standard)
    asn = standard["ASN"]
    asn["id"] = standard.delete("id")
    asn["leaf"] = standard.delete("leaf")
    asn["cls"] = standard.delete("cls")
    asn["authorityStatus"] = standard.delete("authorityStatus")
    asn["indexingStatus"] = standard.delete("indexingStatus")
    asn["statementNotation"] = standard.delete("statementNotation")
    asn["identifier"] = "http://purl.org/ASN/resources/" + standard.delete("identifier") unless standard["identifier"].nil?
    asn["children"] = standard.delete("children")
    asn["parent"] = standard.delete("parent")
  end


  def rename_notations(standard)
    standard["code"] = standard["CCSS"]["dotNotation"]
    standard["shortCode"] = standard["CCSS"].delete("simplifiedDotNotation")
  end


  
end
