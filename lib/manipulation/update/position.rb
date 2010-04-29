module RubyCodeAPI
  module Manipulation  
    module Update
      module Position
        class UpdatePositionError < StandardError
        end
        
        def replace_position_arg(options)
          pos = position_arg?(options[:arg])
          self.arguments.elements[pos.to_i].replace_pos_argument(options)      
        end

        def replace_pos_argument(options)                                    
          case self.arg
          when Ruby::String                                    
            replace_arg_token(options[:with])
          else
            raise UpdatePositionError, "Unknown type for replacing positional argument: #{self.arg.class}"
          end
        end

        def position_arg?(arg)       
          return arg[1] if arg && arg[0]  == '#'
          nil
        end
      end            
    end
  end
end
