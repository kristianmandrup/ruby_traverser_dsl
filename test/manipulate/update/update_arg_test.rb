require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

    define_method :"test find gem statement inside group using DSL and then replace symbol argument with hash argument" do                           
      src = %q{                 
  group :test do
    gem 'ripper', :src
  end  
      }

      code = Ripper::RubyBuilder.build(src)                 
      code.find(:block, 'group', :args => [:test]) do
        call_node = find(:call, 'gem', :args => ['ripper'])
        call_node.update(:select => {:arg => :src}, :with_code => "{:src => 'unknown'}")      
        puts to_ruby
      end       
    end


  
end