module RubyCodeAPI
  module Manipulation  
    module Delete
      class DeleteError < StandardError
      end

      def delete
        # index = parent.find_index(self)
        parent.get_elements.delete(self)    
      end
    end          
  end
end
