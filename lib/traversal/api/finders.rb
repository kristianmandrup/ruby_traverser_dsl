require 'yaml'

module RubyAPI
  module Finders  
    # TODO: use this to generate all methods except for find_block which is special
    NODES = {
      :module => Ruby::Module, 
      :class => Ruby::Class, 
      :variable => [Ruby::Variable, :token], 
      :assignment => [Ruby::Assignment, :left_token], 
      :call => Ruby::Call, 
      :block => Ruby::Call, 
      :def => Ruby::Method
    }
    
    def find(type, name, options = {}, &block) 
      s = send :"find_#{type.to_s}", name, options
      s.extend(options[:extend]) if options[:extend] 
      if block_given?
        block.arity < 1 ? s.instance_eval(&block) : block.call(s)      
      else
        s
      end
    end        

    def find_by(key, type, name, options)
      options.merge!(key => name)
      get_obj.select(type, options).first
    end
    
    def find_module(name, options)
      find_by(:identifier, Ruby::Module, name, options)      
    end

    def find_class(name, options = {})
      find_by(:identifier, Ruby::Class, name, options)      
    end

    def find_variable(name, options = {})                   
      find_by(:token, Ruby::Variable, name, options)            
    end

    def find_assignment(name, options = {})
      find_by(:left_token, Ruby::Assignment, name, options)
    end    

    def find_call(name, options = {})
      find_by(:identifier, Ruby::Call, name, options)      
    end 

    def find_block(name, options = {})  
      options.merge!(:block => true) if !options.has_key?(:block_params)    
      find_by(:identifier, Ruby::Call, name, options)      
    end 

    def find_def(name, options = {})
      find_by(:identifier, Ruby::Method, name, options)      
    end 
    
    alias_method :find_method, :find_def
  end
end  
