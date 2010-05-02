require 'query/find'     
require 'query/ext/simple'
require 'query/ext/call'
require 'query/ext/arg'
require 'query/ext/hash_arg'
require 'query/ext/assoc'

module Ruby
  class Node
    include RubyCodeAPI::Query
  end
end