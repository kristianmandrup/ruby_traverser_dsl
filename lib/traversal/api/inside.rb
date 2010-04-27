module RubyAPI
  module Inside              
    def inside_block(name, options = {}, &block) 
      call_block(find_block(name, options), options, &block)
    end 

    def inside_module(name, &block)
      call_block(find_module(name), options, &block)      
    end

    def inside_class(name, options = {}, &block) 
      call_block(find_class(name, options), options, &block)
    end

    def inside_def(name, options = {}, &block)
      call_block(find_def(name, options), options, &block)
    end
    
    protected
    
    def call_block(s, options, &block)
      # inc_inside_indent
      s.extend(options[:extend]) if options[:extend] 
      block.arity < 1 ? s.instance_eval(&block) : block.call(s)      
    end

    def inside_indent
      if self.class == Ruby::Class
        pos = ldelim.position.col
        puts "pos: #{pos}"
        return pos
      end
      2
    end
    
  end
end
