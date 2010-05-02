module Ruby
  module ModuleExt
    # token is value
    def name      
    end

    def includes
    end

    def methods
    end

    def body
    end
  end
end    
  

module Ruby
  class Module
     include Ruby::ModuleExt
  end
end 
