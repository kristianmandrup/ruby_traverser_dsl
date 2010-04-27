require 'mutate/replacer'

class String
  # Returns an indented string, all lines of string will be indented with count of chars
  def indent(char, count)
    (char * count) + gsub(/(\n+)/) { $1 + (char * count) }
  end
end


module RubyAPI
  module Mutator
    include Replacer
    
    def append_code(code)
      obj = object
      indentation = obj.last_indent  
      code =  "\n#{code}\n".indent(' ', indentation)
      ruby_code = Ripper::RubyBuilder.build(code)
      inject_code = ruby_code.elements[0]
      obj.get_elements << inject_code
      obj
    end

    def append_comment(text)
      append_code("# #{text}")
    end      

    def get_elements
      case self
      when Ruby::Class
        body.elements
      else
        elements
      end
    end


    protected

    def last_indent
      case self
      when Ruby::Block, Ruby::Class
        last_position(get_elements)                           
      else
        puts "unknown: #{obj.class}"
      end
    end

    def last_position(elements) 
      last_element = elements.last
      return position.col if last_element.class == Ruby::Token 
      return last_element.identifier.position.col if elements && elements.size > 0
      inside_indent
    end

    def object
      self.respond_to?(:block) ? self.block : self
    end
    
  end
end

module Ruby
  class Node
    include RubyAPI::Mutator
  end
end
                
