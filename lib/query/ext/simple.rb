module Ruby
  module CompareExt    
    # token is value
    def <=> (obj)
      self.value > float.value
    end    
  end
end

module Ruby
  module IdValue
    include Ruby::CompareExt

    def value      
      identifier.value
    end  
  end
end

module Ruby
  module TokenValue
    include Ruby::CompareExt

    # token is value
    def value      
      token
    end  
    
    def str_val
      value.to_s
    end        
  end
end

module Ruby
  module StrValue
    def value             
      elements[0].value
    end         
  end
end


# Ripper2Ruby class extensions

module Ruby   
  class Ruby::Node::Composite::Array
    def value
      map do |e|
        e.value
      end
    end    
  end

  
  class Token
    def value
      token
    end    
  end

  class Identifier
    def value
      token
    end    
  end

  class StringContent
    def value
      token
    end
  end
  
  class True
    def value
      true
    end
  end

  class False
    def value
      false
    end
  end

  class Nil
    def value
      nil
    end
  end

  class Const

    def value      
      Kernel.const_get(str_val)
    end  
    
    def str_val
      identifier.value
    end    
  end

  class Symbol

    def value      
      str_val.to_sym
    end  
    
    def str_val
      identifier.value
    end    
  end


  class Regexp
    include Ruby::StrValue
    
    def to_regexp
      /#{::Regexp.escape(value)}/
    end    
    
  end

  class Char
    include Ruby::TokenValue
  end
  
  class Float
    include Ruby::TokenValue
  end

  class Integer
    include Ruby::TokenValue    
  end

  class String 
    include Ruby::StrValue
  end

  class Range
    def value 
      (left.value..right.value)
    end

    def str_val
      value.to_s
    end

    def first
      left.value
    end

    def last    
      right.value
    end
    
  end

  
end