require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{    
      my_block :a, 'b', 2 do |d, e, f|        
        a = 3
      end
    }    
        
    code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
  end

  define_method :"test deletes first argument" do
    assert_equal 'a', @node[0]    
    @node.arguments.first.delete
    assert_equal 2, @node.arguments.size    
    assert_equal :b, @node[0]    
  end

  define_method :"test deletes last argument" do
    assert_equal 2, @node.last.value    
    @node.last.delete
    assert_equal 'b', @node.last.value    
  end

  define_method :"test deletes all arguments" do
    assert_equal 3, @node.arguments.size    
    @node.arguments.delete_all!
    assert @node.arguments.empty?    
  end

end