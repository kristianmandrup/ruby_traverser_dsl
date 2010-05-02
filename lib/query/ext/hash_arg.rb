module Ruby
  class Hash
    include Enumerable

    def hash_assoc(index = 0)
      self[index]
    end             

    def each
      elements.each{|a| yield a}
    end

    def empty?
      elements.empty?
    end
    
    def [] index
      elements[index]
    end
    
    def last          
      elements[-1]
    end
    
    def key
      elements[0].name             
    end

    def value
      elements[0].value             
    end

    def keys             
    end
    
    def values
    end
  end
end