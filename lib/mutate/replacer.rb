module PositionReplacer
  def replace_position_arg(options)
    pos = position_arg?(options[:arg])
    self.arguments.elements[pos.to_i].replace_pos_argument(options)      
  end

  def replace_pos_argument(options)                                    
    case self.arg
    when Ruby::String                                    
      replace_arg_token(options[:replace_arg])
    end
  end

  def position_arg?(arg)       
    return arg[1] if arg && arg[0]  == '#'
    nil
  end
end

module TokenReplacer
  def replace_arg_token(replacement)
    self.arg.elements[0].token = replacement         
  end

  def matching_string_arg?(txt)
    self.arg.elements[0].token == txt
  end                    
end

module HashReplacer
  def hash_arg?(arg) 
    case arg
    when Hash 
      matching_hash_arg?(arg)
    when Symbol
      matching_symbol_arg?(arg)      
    end
  end                    

  def replace_hash_arg(options) 
    src = options[:replace_code]        
    code = Ripper::RubyBuilder.build(src)
    code.set_ldelim(self.arg) 
    self.arg = code
  end

  def set_ldelim(arg)
    if arg.respond_to? :elements
      self.ldelim = arg.elements[0].key.ldelim
      self.ldelim.token = ''
    else                  
      self.ldelim = arg.ldelim
    end
  end
  
  def matching_hash_arg?(arg)
    if self.arg.respond_to? :elements
      if self.arg.elements[0].class == Ruby::Assoc
        key = self.arg.elements[0].key
        value = self.arg.elements[0].value
        arg_key = arg.first[0]
        arg_value = arg.first[1]
        return key.identifier.token.to_sym == arg_key && value.elements[0].token == arg_value
      end
    end
    false
  end
  
  def matching_symbol_arg?(arg)
    if self.arg.respond_to? :elements
      if self.arg.elements[0].class == Ruby::Assoc
        return self.arg.elements[0].key.identifier.token.to_sym == arg
      end
    else
      # remove ':' token from symbol      
      self.arg.ldelim.token = ''
      return self.arg.identifier.token.to_sym == arg       
    end
    false
  end
end


module RubyAPI
  module Mutator
    module Replacer
      include PositionReplacer
      include TokenReplacer  
      include HashReplacer        
      
      # :arg => 'ripper', :replace_arg => 'rapper'
      def replace(options)                       
        if position_arg?(options[:arg])
          return replace_position_arg(options) 
        end
        
        self.arguments.elements.each_with_index do |elem, i|
          case elem
          when Ruby::Arg
            if elem.hash_arg?(options[:arg])
              return elem.replace_hash_arg(options) 
            end
            elem.replace_argument(options)
          end
        end
      end

      def replace_argument(options)                                    
        case self.arg
        when Ruby::String                                    
          replace_arg_token(options[:replace_arg]) if matching_string_arg?(options[:arg])  
        end
      end

    end
  end
end