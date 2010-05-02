module Ruby
  class Call
    include Enumerable    
    
    def each
      arguments.each{|a| yield a}
    end

    def empty?
      arguments.empty?
    end
    
    def [] index
      arguments[index]
    end
    
    def last          
      arguments[-1]
    end
  end
end