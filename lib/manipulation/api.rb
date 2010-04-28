require 'manipulation/update/api'
require 'manipulation/delete/api'
require 'manipulation/insert/api'
require 'manipulation/position'
require 'manipulation/helpers'

module RubyCodeAPI
  module Manipulation  
    include Insert
    include Update
    include Delete 
    include RubyCodeAPI::Misc::Position
    include RubyCodeAPI::Misc::Helper    
  end
end

module Ruby
  class Node
    include RubyCodeAPI::Manipulation
  end
end

# Core extensions

class String
  # Returns an indented string, all lines of string will be indented with count of chars
  def indent(char, count)
    (char * count) + gsub(/(\n+)/) { $1 + (char * count) }
  end
end
