module ASNFlattener


  def flatten
    flat = []
    self.doc.each do |branch|
      flat << branch
      push_children(flat, branch)
    end
    self.doc = flat
    self
  end

  def push_children(container, element)
    if element.is_a?(Hash) && element.has_key?("children")
      element['children'].each do |el|
        el[:asnParent] = element['id']
        container << el 
          push_children(container, el)
        end
      end
      element.delete("children")
  end
  
end
