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

  define_method :"test deletes first param" do
    assert_equal 'd', @node.params[0]    
    @node.params.first.delete
    assert_equal 2, @node.params.size    
    assert_equal 'e', @node[0]    
  end

  define_method :"test deletes last param" do
    assert_equal 'f', @node.params.last.value    
    @node.params.last.delete
    assert_equal 'e', @node.last.value    
  end

  define_method :"test deletes all params" do
    assert_equal 3, @node.params.size    
    @node.params.delete_all!
    assert @node.params.empty?    
  end

  define_method :"test deletes all params" do
    assert_equal 3, @node.params.size    
    @node.params.delete_all!
    assert @node.params.empty?    
  end  
end