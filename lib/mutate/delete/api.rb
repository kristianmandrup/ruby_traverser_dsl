module Deleter
  def delete
    # index = parent.find_index(self)
    parent.get_elements.delete(self)    
  end
end  
