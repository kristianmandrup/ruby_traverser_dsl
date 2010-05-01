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

# TODO
        
# call_node.update(:select => {:arg => :src}, :with_code => "{:src => 'unknown'}")      
# 
# update changes to:
# --
# n.find(:arg => :src).update!(:arg => :unknown)
# 
# n.find(:arg => :src).update! do
#   "{:src => 'unknown'}"
# end

# update should work on:
# * Ruby::Module, identifier
# * Ruby::Class, identifier 
# * Ruby::Variable
#  - identifier
#  - value
# 
# * Ruby::Call
#  - identifier
#  - param
#  - block_param
# 
# * Ruby::Method
#  - identifier
#  - param
# 
# delete argument
# ---
# node.find(:arg => :src).delete!
# 
# Extra functionality
# ---
# - add/remove include ModuleName
# - add/remove extend ModuleName
