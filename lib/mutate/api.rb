require 'mutate/replacer'

require 'singleton'

class RubyAPIConfig
  include Singleton
  
  attr_accessor :inside_indent

  def initialize
    @inside_indent ||= 0    
  end
    
  def inc_inside_indent
    @inside_indent += 2
  end
  
end

module RubyAPI
  module Mutator
    include Replacer
    
    def append_code(code)
      obj = object
      indent = obj.last_indent  
      puts "indent: #{indent}"
      code =  "\n" + (' ' * indent) + code + "\n"
      ruby_code = Ripper::RubyBuilder.build(code)
      obj.get_elements << ruby_code.elements[0]
    end

    def get_elements
      case self
      when Ruby::Class
        body.elements
      else
        elements
      end
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
      when Ruby::Block, Ruby::Class
        last_position(get_elements)                           
      else
        puts "unknown: #{obj.class}"
      end
    end

    def last_position(elements) 
      return elements.last.identifier.position.col if elements && elements.size > 0
      puts "returning inside indent: #{inside_indent}"
      RubyAPIConfig.instance.inside_indent
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
                
