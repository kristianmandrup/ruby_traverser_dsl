module RubyCodeAPI
  module Manipulation  
    module Update
      module Hash
        def hash_arg?(arg) 
          case arg
          when Hash 
            matching_hash_arg?(arg)
          when Symbol
            matching_symbol_arg?(arg)      
          end
        end                    

        def replace_hash_arg(options) 
          src = options[:replace_code]        
          code = Ripper::RubyBuilder.build(src)
          code.set_ldelim(self.arg) 
          self.arg = code
        end

        def set_ldelim(arg)
          if arg.respond_to? :elements
            self.ldelim = arg.elements[0].key.ldelim
            self.ldelim.token = ''
          else                  
            self.ldelim = arg.ldelim
          end
        end
  
        def matching_hash_arg?(arg)
          if self.arg.respond_to? :elements
            if self.arg.elements[0].class == Ruby::Assoc
              key = self.arg.elements[0].key
              value = self.arg.elements[0].value
              arg_key = arg.first[0]
              arg_value = arg.first[1]
              return key.identifier.token.to_sym == arg_key && value.elements[0].token == arg_value
            end
          end
          false
        end
  
        def matching_symbol_arg?(arg)
          if self.arg.respond_to? :elements
            if self.arg.elements[0].class == Ruby::Assoc
              return self.arg.elements[0].key.identifier.token.to_sym == arg
            end
          else
            # remove ':' token from symbol      
            self.arg.ldelim.token = ''
            return self.arg.identifier.token.to_sym == arg       
          end
          false
        end
      end
    end
  end
end