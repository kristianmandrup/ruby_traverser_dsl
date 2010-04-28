require 'query/api'
require 'manipulation/api'
require 'config/mixin'

module Ruby
  class Node
    include RubyCodeAPI::Query
    include RubyCodeAPI::Manipulation 
    include RubyCodeAPI::Misc    
  end
end