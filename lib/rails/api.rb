require 'rails/gemfile'

module RubyCodeAPI
  module Rails
    include Gemfile
  end
end

module Ruby
  class Node
    include RubyCodeAPI::Rails
  end
end