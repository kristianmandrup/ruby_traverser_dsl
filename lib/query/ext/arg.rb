module Ruby
  class Arg

    def hash_assoc(index = 0)
      arg.class == Ruby::Hash ? arg[index] : nil
    end             
    
    def <=> (arg)
      arg[0] <=> arg[0]
    end
  end
end