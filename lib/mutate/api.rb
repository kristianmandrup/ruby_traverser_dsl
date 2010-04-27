module RubyAPI
  module Mutator
    def append_code(code)
      obj = object
      indent = obj.last_indent
      code =  "\n" + (' ' * indent) + code
      ruby_code = Ripper::RubyBuilder.build(code)
      obj.elements << ruby_code.elements[0]
    end

    # :arg => 'ripper', :replace_arg => 'rapper'
    def replace(options)
      arguments.elements.each do |elem|
        puts "ELEMENT:"
        puts elem.to_yaml
      end
    end
    
    protected

    def last_indent
      case self
      when Ruby::Block
        elements.last.identifier.position.col        
      else
        puts "unknown: #{obj.class}"
      end
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
                
