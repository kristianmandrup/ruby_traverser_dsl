module RubyAPI
  module Finders
    def find_module(name)
      get_obj.select(Ruby::Module, :identifier => name).first
    end

    def find_class(name, options = {})
      options.merge!(:identifier => name)
      get_obj.select(Ruby::Class, options).first    
    end

    def find_call(name, options = {})
      options.merge!(:identifier => name)      
      obj = get_obj(options)   
      return obj.select(Ruby::Call, options).first if obj.class != Ruby::Call
      obj
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
