require 'traversal/module'
require 'traversal/misc'
require 'traversal/patch'

module Ruby
  class Node
    include Traversal::Module
    include Traversal::Misc
    include Traversal::Patch      
    
    def has_const?(value)
      if respond_to?(:const)
        if namespace?(value)
          name = value.split('::').last
          return self.const.identifier.token == name
        end
      end
      false
    end

    def has_block?
      respond_to? :block
    end      

    def has_namespace?(value)
      if respond_to?(:namespace)
        return self.namespace.identifier.token == value
      end
      false
    end

    def has_identifier?(value)
      if respond_to?(:identifier)
        id = self.identifier

        if namespace?(value)
          return id.token.to_s == value.to_s if id.respond_to?(:token)
          if id.respond_to?(:identifier)
            name = value.split('::').last
            return id.identifier.token == name
          end
        end
      else
        has_const?(value)
      end
    end
  end    
end   

     