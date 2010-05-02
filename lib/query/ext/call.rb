module Ruby
  class Call
    include Enumerable    
    include Ruby::IdValue

    def name
      identifier.token
    end

    def value
      to_ruby
    end

    
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