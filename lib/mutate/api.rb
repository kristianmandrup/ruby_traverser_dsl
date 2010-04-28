require 'mutate/replacer'

class String
  # Returns an indented string, all lines of string will be indented with count of chars
  def indent(char, count)
    (char * count) + gsub(/(\n+)/) { $1 + (char * count) }
  end
end


module Deleter
  def delete
    # index = parent.find_index(self)
    parent.get_elements.delete(self)    
  end
end  

module Inserter
  def append_code(code)
    return append_code_simple(code) if !elemental?
    obj = object
    indentation = obj.last_indent  
    code =  "\n#{code}\n".indent(' ', indentation)
    ruby_code = Ripper::RubyBuilder.build(code)
    inject_code = ruby_code.elements[0]
    obj.get_elements << inject_code
    inject_code
  end

  def append_code_simple(code)
    indentation = position.col
    code =  "\n#{code}\n".indent(' ', indentation)
    ruby_code = Ripper::RubyBuilder.build(code)
    inject_code = ruby_code.elements[0]
    index = parent.find_index(self)
    parent.get_elements.insert(index+1, inject_code)
    inject_code
  end

  def prepend_code(code)
    obj = object
    indentation = obj.first_indent  
    code =  "\n#{code}\n".indent(' ', indentation)
    ruby_code = Ripper::RubyBuilder.build(code)
    inject_code = ruby_code.elements[0]
    obj.get_elements.insert(0, inject_code)
    obj
  end

  def insert_comment(position, text, &block)
    insert(position, "# #{text}", &block)    
  end
  
  def insert(position, code, &block)
    case position
    when :after
      s = append_code(code)
    when :before
      s = prepend_code(code)
    else
      raise Error, "Invalid position given: #{position}, must be either :before or :after"
    end  
    
    if block_given?
      block.arity < 1 ? s.instance_eval(&block) : block.call(s)      
    else
      s
    end    
  end
  
end

module RubyAPI
  module Mutator
    include Replacer
    include Deleter 
    include Inserter


    def find_index(obj)
      get_elements.each_with_index do |elem, i|
        if elem == obj
          return i
        end
      end        
    end

    def elemental?
      respond_to?(:body) || respond_to?(:elements)
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
      return position.col 
      return position.col if simple_pos?(last_element)
      return last_element.identifier.position.col if elements && elements.size > 0
      inside_indent
    end

    def simple_pos?(elem)       
      [Ruby::Token, Ruby::Variable].include?(elem.class)
    end

    def first_indent
      case self
      when Ruby::Block, Ruby::Class
        first_position(get_elements)                           
      else
        puts "unknown: #{obj.class}"
      end
    end

    def first_position(elements) 
      first_element = elements.first
      return position.col if simple_pos?(first_element)
      return first_element.identifier.position.col if elements && elements.size > 0
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
                
