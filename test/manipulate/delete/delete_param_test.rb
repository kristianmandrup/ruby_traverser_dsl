require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{                 
    def method(a, b, c)
    end
    }
    code = Ripper::RubyBuilder.build(src)
    node = code[0]  
  end

  define_method :"test delete single param by number position" do                           
    @node.params[1].delete!                 
    assert_equal 1, node.params.size, "params count 2"
    assert_equal 'c', node.params[1].name, "param[1] name 'c' "
  end
  
  define_method :"test delete first param" do                           
    @node.params.first.delete!                 
    assert_equal 1, node.params.size, "params count 2"
    assert_equal 'b', node.params.first.name, "first param name 'b' "
  end

  define_method :"test delete first param" do                           
    @node.params.last.delete!                 
    assert_equal 1, node.params.size, "params count 2"
    assert_equal 'b', node.params.last.name, "last param name 'b' "
  end
end