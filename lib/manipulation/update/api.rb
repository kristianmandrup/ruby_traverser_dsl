require 'manipulation/update/value'
require 'manipulation/update/position'
require 'manipulation/update/hash'
require 'manipulation/update/token'

module RubyCodeAPI
  module Manipulation  
    module Update
      include Position
      include Token  
      include Hash
      include Value              

      class UpdateError < StandardError
      end      

      # update :select => {...}, :with => {...}
      # update :select => {...}, :with_code => 'code'
      def update(options, &block)                
        s = replace_value(options) if options[:value]
        s = replace options[:select].merge(options) if options[:select]        
        if block_given?
          block.arity < 1 ? s.instance_eval(&block) : block.call(s)      
        else
          s
        end        
      end
      
      # :arg => 'ripper', :replace_arg => 'rapper'
      def replace(options)                               
        return replace_value(options) if options[:value]
        if position_arg?(options[:arg])
          puts "POSITION ARG"
          return replace_position_arg(options) 
        end
        return replace_arg(options) if options[:arg]
        raise UpdateError, "Invalid replace options: #{options}"
      end

      def replace_arg(options)
        self.arguments.elements.each_with_index do |elem, i|
          case elem
          when Ruby::Arg
            if elem.hash_arg?(options[:arg])
              return elem.replace_hash_arg(options) 
            end
            elem.replace_argument(options)
          end
        end
      end

      def replace_argument(options)                                    
        case self.arg
        when Ruby::String                                    
          replace_arg_token(options[:with]) if matching_string_arg?(options[:arg])  
        else
          raise UpdateError, "Invalid replace_argument options: #{options}"          
        end
      end

    end
  end
end