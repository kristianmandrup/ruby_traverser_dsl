require 'yaml'

module RubyCodeAPI
  module Query  
    # Use this to generate all methods except for find_block which is a bit special
    NODES = {
      :module => Ruby::Module, 
      :class => Ruby::Class, 
      :variable => [Ruby::Variable, :token], 
      :assignment => [Ruby::Assignment, :left_token], 
      :call => Ruby::Call, 
      :def => Ruby::Method
    }

    class FindError < StandardError
    end      
    
    def find(type, name, options = {}, &block) 
      s = send :"find_#{type.to_s}", name, options
      s.extend(options[:extend]) if options[:extend] 
      if block_given?
        block.arity < 1 ? s.instance_eval(&block) : block.call(s)      
      else
        s
      end
    end        

    def inside(type, name, options = {}, &block) 
      raise FindError, "Must have block argument" if !block_given?
      find(type, name, options = {}, &block)       
    end

    instance_eval do   
      NODES.each_pair do |key, value| 
        case value
        when Array
          define_method :"find_#{key}" do |name, options|
            find_by(value[1], value[0], name, options)                
          end
        else
          define_method :"find_#{key}" do |name, options|
            find_by(:identifier, value, name, options)                
          end
        end
      end
    end

    def find_by(key, type, name, options)
      options.merge!(key => name)
      get_obj.select(type, options).first
    end

    def find_block(name, options = {})  
      options.merge!(:block => true) if !options.has_key?(:block_params)    
      find_by(:identifier, Ruby::Call, name, options)      
    end 
    
    alias_method :find_method, :find_def    
    
    protected
    
      def inside_indent
        if self.class == Ruby::Class
          pos = ldelim.position.col
          return pos
        end
        2
      end

      def get_obj(options = {})
        return self.block if self.class == Ruby::Method     
        self
      end  
    
  end
end  
