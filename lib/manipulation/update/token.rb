module RubyCodeAPI
  module Manipulation  
    module Update
      module Token
        def replace_arg_token(replacement)
          self.arg.elements[0].token = replacement         
        end

        def matching_string_arg?(txt)
          self.arg.elements[0].token == txt
        end                    
      end         
    end
  end
end