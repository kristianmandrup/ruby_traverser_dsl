module RubyAPI
  module Inside              
    def inside(type, name, options = {}, &block) 
      s = find(type, name, options)
      s.extend(options[:extend]) if options[:extend] 
      if block_given?
        block.arity < 1 ? s.instance_eval(&block) : block.call(s)      
      else
        s
      end
    end        
        
    protected
    
    def inside_indent
      if self.class == Ruby::Class
        pos = ldelim.position.col
        return pos
      end
      2
    end
    
  end
end
