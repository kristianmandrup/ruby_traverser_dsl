require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  # use cases
  # delete single arg, by matching position, name or "full value"
  # delete range og args
  # delete args using enumerator, fx reject!
  # delete all args    

  define_method :"setup" do                           
    src = %q{    
      hello_world 'a', :b, 2
    }    
        
    code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
  end

  define_method :"test deletes first argument" do
    assert_equal 'a', @node[0]    
    @node.first.delete
    assert_equal 2, @node.size    
    assert_equal :b, @node[0]    
  end

  define_method :"test deletes last argument" do 
    assert_equal :c, @node[-1]    
    @node.last.delete
    assert_equal 2, @node.size    
    assert_equal :b, @node[-1]    
  end

  define_method :"test delete second argument" do
    assert_equal :b, @node[1]    
    @node[1].delete
    assert_equal 2, @node.size    
    assert_equal 2, @node[1]    
  end

  define_method :"test delete argument :b" do      
    assert_equal :b, @node[1]    
    @node.delete(:b)
    assert_equal 2, @node.size    
    assert_equal 2, @node[1]    
  end

  define_method :"test delete argument 'a'" do      
    assert_equal :b, @node[1]    
    res = @node.find('a').delete
    assert_equal 2, @node.size    
    assert_equal :b, @node[0]    
    assert_equal @node, res    
  end

  define_method :"test delete argument that doesn't exist'" do      
    assert_equal :b, @node[1]    
    res = @node.delete('c')
    assert_equal 3, @node.size
    assert_equal @node, res
  end

end