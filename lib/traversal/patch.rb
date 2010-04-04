module Ruby
  class Node
    module Traversal
      module Patch
        def select(*args, &block)
          result = []
          result << self if matches?(args.dup, &block)
          children = (prolog.try(:elements).to_a || []) + nodes
          children.flatten.compact.inject(result) do |result, node|
            if node.class.to_s == 'Symbol'
              return result
            end
            result + node.select(*args, &block)
          end
        end

        def matches?(args, &block) 
          conditions = args.last.is_a?(::Hash) ? args.pop : {}
          conditions[:is_a] = args unless args.empty?

          conditions.inject(!conditions.empty?) do |result, (type, value)|
            result && case type
            when :is_a
              has_type?(value)
            when :class
              is_instance_of?(value)
            when :token
              has_token?(value)
            when :value
              has_value?(value)
            when :identifier
              has_identifier?(value)
            when :const
              has_const?(value)
            when :block
              has_block?
            when :namespace          
              has_namespace?(value)
            when :superclass
              superclass?(value)
            when :args, :params
              args?(value)                        
            when :block_params          
              args?(value, :withblock)          
            when :pos, :position
              position?(value)
            when :right_of
              right_of?(value)
            when :left_of
              left_of?(value)
            end
          end && (!block_given? || block.call(self))
        end
      end # Patch
    end
  end
end
