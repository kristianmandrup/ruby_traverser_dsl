module Ruby
  class Node
    module Extension
      module Patch
        def select(*args, &block)
          result = []
          result << self if matches?(args.dup, &block)
          children.flatten.compact.inject(result) do |result, node|
            if node.class.to_s == 'Symbol'
              return result
            end
            selected = node.select(*args, &block)                        
            result + selected
          end   
        end

        def children
          (self.try(:elements).to_a || prolog.try(:elements).to_a || []) + nodes
        end

        def matches?(args, &block) 
          conditions = args.last.is_a?(::Hash) ? args.pop : {}
          conditions[:is_a] = args unless args.empty?

          if conditions[:is_a]
            type_condition = conditions[:is_a][0]
            if type_condition
              return nil if !has_type?(type_condition)
            end
          end

          res = conditions.inject(!conditions.empty?) do |result, (type, value)|
            block_result = (!block_given? || block.call(self))
            check_res = check_pair(type, value)
            return false if !check_res
            result && check_res && block_result
          end
          res
        end
    
        def check_pair(type, value)
          res = case type
          when :is_a
            has_type?(value)
          when :class
            is_instance_of?(value)
          when :token
            has_token?(value)
          when :left_token
            left.has_token?(value)
          when :right_token
            right.has_token?(value)
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
          else
            true
          end
          # puts "check pair type:#{type}, value:#{value} => #{res}, self: #{self.inspect}" if self.class == Ruby::Variable 
          res
        end 
    
      end # Patch
    end
  end
end