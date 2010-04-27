require 'traversal/api/finders'
require 'traversal/api/inside'

module RubyAPI 
  include Finders
  include Inside   
  
  protected
  
  def get_obj(options = {})
    # pp self if options[:verbose]      
    if self.class == Ruby::Method     
      obj = self.block 
      puts "size: #{obj.size}"
      if obj.size == 1
        return obj[0] 
      else
        return obj[1]      
      end
    end
    self
  end  
end

module Ruby
  class Node
    include RubyAPI
  end
end