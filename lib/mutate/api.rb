require 'mutate/replacer'

module RubyAPI
  module Mutator
    include Replacer
    
    def append_code(code)
      obj = object
      indent = obj.last_indent
      code =  "\n" + (' ' * indent) + code
      ruby_code = Ripper::RubyBuilder.build(code)
      obj.elements << ruby_code.elements[0]
    end



    # --- &id003 !ruby/object:Ruby::Arg 
    # arg: &id001 !ruby/object:Ruby::String 
    #   elements: !seq:Ruby::Node::Composite::Array 
    #     - !ruby/object:Ruby::StringContent 
    #       parent: *id001
    #       position: !ruby/object:Ruby::Node::Position 
    #         col: 7
    #         row: 2
    #       prolog: !ruby/object:Ruby::Prolog 
    #         elements: !seq:Ruby::Node::Composite::Array []
    # 
    #       token: ripper
    
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
                
