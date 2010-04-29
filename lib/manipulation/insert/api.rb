module RubyCodeAPI
  module Manipulation  
    module Insert
      class InsertError < StandardError
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
          raise InsertError, "Invalid position given: #{position}, must be either :before or :after"
        end  
    
        if block_given?
          block.arity < 1 ? s.instance_eval(&block) : block.call(s)      
        else
          s
        end    
      end  

      protected
      
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

    end  
  end
end