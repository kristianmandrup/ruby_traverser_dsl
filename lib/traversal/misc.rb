module Ruby
  class Node
    module Traversal
      module Misc
        def args?(value, with_block = nil)
          found = 0        
          obj = has_a_block?(with_block) ? self.block : self
          args_list = get_args_list(obj)
          return false if !args_list    
          args_list.elements.each do |arg|    
            argument = retrieve_arg(arg) 
            value.each do |v|            
              v = v[:array] if v.respond_to?(:has_key?) && v[:array]              
              found += 1 if argument == v
            end
          end       
          return found == value.size
        end                             
        
        def has_a_block?(with_block)
          with_block && self.respond_to?(:block)
        end

        def get_args_list(obj)                         
          return obj.params if obj.respond_to? :params 
          return obj.arguments if obj.respond_to? :arguments 
          # return obj if obj.class == Ruby::ArgsList       
        end

        def resolve_arg_wrapper(arg_wrapper)
          return arg_wrapper.arg if arg_wrapper.respond_to? :arg            
          return arg_wrapper.param if arg_wrapper.respond_to? :param            
          return arg_wrapper if arg_wrapper.class == Ruby::Arg
          arg_wrapper
        end

        def retrieve_arg(arg_wrapper)
          arg = resolve_arg_wrapper(arg_wrapper)
          argument = get_arg(arg)       
          convert_value(argument, arg)
        end

        def convert_value(value, type = nil)
          type_val = type || value
          case type_val                    
          when Ruby::Symbol  
            value.to_sym
          when Ruby::Integer
            value.to_i                          
          when Ruby::Float
            value.to_f        
          when Ruby::Hash
            type ? get_hash(type) : value       
          when Ruby::Array
            type ? get_array(type) : value       
          when Ruby::Assoc   
            return get_assoc(type)
          else
            value
          end
        end      

        def get_arg(arg)  
          get_symbol(arg) || get_assoc(arg) || get_composite(arg) || get_identifier(arg) || get_token(arg) || resolve_arg_wrapper(arg)
        end

        def get_symbol(arg)
          return nil if !(arg.class == Ruby::Symbol)
          t = get_token(arg)
          t ? t.to_sym : nil
        end

        def get_composite(arg)
          return nil if !arg.respond_to? :elements
          e = arg.elements
          return get_arg(e[0]) if e.size == 1
          get_hash(e) || get_array(e)
        end

        def get_array(args)
          return nil if arg.class != Ruby::Array
          arr = []  
          args.each do |arg|
             arr << get_arg(arg)
          end
          return arr if !arr.empty?
          nil
        end 

        def get_hash(args)    
          return nil if !args.class == Ruby::Hash
          items = args.respond_to?(:elements) ? args.elements : args 
          hash = {}  
          items.each do |arg|  
             hash_val = get_arg(arg) 
             hash.merge!(hash_val)
          end    
          return hash if !hash.empty?
          nil
        end 

        def get_assoc(arg)
          return nil if !(arg.class == Ruby::Assoc) 
          get_hash_item(arg)      
        end

        def get_hash_item(arg)   
          return if !arg.respond_to? :key      
          key = get_key(arg.key)
          value = get_value(arg.value)
          return {key => value}
        end

        def get_key(key)             
          if key.respond_to? :identifier
           id = get_identifier(key)
          end
          return id.to_sym if key.class == Ruby::Symbol
          return get_token(key) if key.class == Ruby::Variable
          id
        end

        # Needs rework!
        def get_value(value)
          real_value = get_arg(value)
          convert_value(real_value, value)
        end

        def get_identifier(arg)
          get_token(arg.identifier) if arg.respond_to? :identifier
        end

        def get_string(arg)
          get_token(arg.elements[0]) if arg.class == Ruby::String
        end

        def get_token(arg)                             
          arg.token if arg.respond_to? :token
        end
      end
    end
  end        
end