class String
  # Returns an indented string, all lines of string will be indented with count of chars
  def indent(char, count)
    (char * count) + gsub(/(\n+)/) { $1 + (char * count) }
  end
end

module Helper
  def find_index(obj)
    get_elements.each_with_index do |elem, i|
      if elem == obj
        return i
      end
    end        
  end

  def elemental?
    respond_to?(:body) || respond_to?(:elements)
  end

  def get_elements
    case self
    when Ruby::Class
      body.elements
    else
      elements
    end
  end

  def object
    self.respond_to?(:block) ? self.block : self
  end
end