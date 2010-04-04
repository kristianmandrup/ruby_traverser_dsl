require 'traversal/api/finders'
require 'traversal/api/inside'

module RubyAPI 
  include Finders
  include Inside   

protected
  def get_obj  
    return self.block[1] if self.class == Ruby::Method     
    self
  end
end

module Ruby
  class Node
    include RubyAPI
  end
end