require 'mutate/update/api'
require 'mutate/delete/api'
require 'mutate/insert/api'
require 'mutate/position'
require 'mutate/helpers'

module RubyAPI
  module Mutator
    include Replacer
    include Deleter 
    include Inserter
    include Position
    include Helper
    
  end
end

module Ruby
  class Node
    include RubyAPI::Mutator
  end
end
                
