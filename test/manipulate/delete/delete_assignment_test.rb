require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{    
      a = 2
      a = 3
    }    
        
    code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
  end

  define_method :"test deletes assignment" do
    assert_equal 'a', @node[0]    
    @node.delete
    assert_equal 2, @node.size    
    assert_equal :b, @node[0]    
  end

  define_method :"test deletes assignment with matching variable name 'a'" do
    assert_equal 2, @node[0].value    
    @node.delete(:name => :a)
    assert_equal 3, @node[0].value    
  end

  define_method :"test deletes assignment with matching variable name 'a'" do
    assert_equal 2, @node[0].value    
    @node.delete(:value => :2)
    assert_equal 3, @node[0].value    
  end

  define_method :"test deletes assignment with matching variable name 'a' (alternative)" do
    assert_equal 2, @node[0].value    
    @node.where(:value => :2).delete
    assert_equal 3, @node[0].value    
  end

  
end