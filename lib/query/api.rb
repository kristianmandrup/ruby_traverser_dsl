require 'query/find'     
require 'query/ext/simple'
require 'query/ext/call'

module Ruby
  class Node
    include RubyCodeAPI::Query
  end
end