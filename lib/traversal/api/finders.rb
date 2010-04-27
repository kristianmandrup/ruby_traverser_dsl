require 'yaml'

module RubyAPI
  module Finders
    def find_module(name)
      get_obj.select(Ruby::Module, :identifier => name).first
    end

    def find_class(name, options = {})
      options.merge!(:identifier => name)
      get_obj.select(Ruby::Class, options).first    
    end

    def find_variable(name, options = {})
      options.merge!(:token => name)      
      get_obj.select(Ruby::Variable, options).first      
    end

    def find_assignment(name, options = {})
      options.merge!(:left_token => name)      
      get_obj.select(Ruby::Assignment, options).first      
    end    

    def find_call(name, options = {})
      options.merge!(:identifier => name)      
      get_obj.select(Ruby::Call, options).first
    end 

    def find_block(name, options = {})  
      options.merge!(:identifier => name)
      options.merge!(:block => true) if !options.has_key?(:block_params)    
      get_obj.select(Ruby::Call, options).first    
    end 


    def find_def(name, options = {})
      options.merge!(:identifier => name)
      get_obj.select(Ruby::Method, options).first
    end 
  end
end  
