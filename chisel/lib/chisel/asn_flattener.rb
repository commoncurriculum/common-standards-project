module ASNFlattener


  def flatten
    flat = []
    self.doc.each_with_index do |doc, i|
      flat << doc
      push_children(flat, doc)
    end
    self.doc = flat
    self
  end

  def push_children(container, element)
    if element.is_a?(Hash) && element.has_key?("children")
      ids = element['children'].collect{|el| el['id']}
      element['children'].each do |el|
        el['parent'] = element['id']
        container << el 
          push_children(container, el)
        end
      end
      element["children"] = ids
  end
  
end
