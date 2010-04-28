module Ruby
  class Node
    module Extension
      module Module
        def namespace?(full_name)
          if full_name.split('::').size > 1
            namespaces = full_name.split('::')[0..-2]
            namespace = namespaces.join('::')

            if class_or_module?
              return module_namespace?(namespace)
            end
          end
          true
        end

        def class_or_module?
          [Ruby::Class, Ruby::Module].include?(self.class)
        end

        def module_namespace?(namespace)
          namespace == get_full_namespace(get_namespace) 
        end

        def get_namespace
          return self.const.namespace if self.respond_to?(:const)
          self.identifier.namespace      
        end

        def get_full_namespace(ns)
          if ns.respond_to?(:namespace)
            name = ns.identifier.token 
            parent_ns = get_full_namespace(ns.namespace)
            name += ('::' + parent_ns) if !parent_ns.empty?
            return name.split('::').reverse.join('::')
          else
            return ns.identifier.token if ns.respond_to?(:identifier)
            ""
          end
        end      

        def superclass?(value)      
          if class_or_module?
            ns = get_full_namespace(self.super_class) 
            return ns == value
          end
          false      
        end
      end
    end
  end
end