module RubyCodeAPI
  module Misc
    module Helper
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

      def object
        self.respond_to?(:block) ? self.block : self
      end
    end      
  end
end