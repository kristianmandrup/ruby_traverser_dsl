module RubyCodeAPI
  module Manipulation  
    module Update
      module Value
        def replace_value(options)
          if self.class == Ruby::Assignment 
            self.right.token = options[:value]
          end
        end 
      end         
    end
  end
end
