module Ruby
  class Arg
    def name
    end
    
    def <=> (arg)
      arg.elements[0] <=> arg.elements[0]
    end
  end
end