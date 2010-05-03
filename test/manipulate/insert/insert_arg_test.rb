require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{    
      hello_world 'a', :b, 2, 'a', 'ab'
    }    
        
    code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
  end
  
  define_method :"test insert arg before arg :b" do
    res = @node.before(:arg, :b).insert('y') 
    assert_equal 'y', @node.first.value
  end

  define_method :"test update arg after arg :b" do
    res = @node.after(:arg, :b).insert('y') 
    assert_equal 'y', @node.last.value
  end

  define_method :"test update arg after arg :b" do      
    res = @node.after(:arg, 'a').insert(:code => 'call_me(5)') 
    assert_equal 'call_me(5)', @node[1].value.to_ruby    
  end
  
  define_method :"test before :arg insert " do        
    my_other_node = node.find(:arg, 'a')
    res = @node.before(:arg, 2).insert(my_other_node) 
    assert_equal 'a', @node[1].value    
  end

  define_method :"test update arg after arg :b" do      
    res = @node.args.before(:x).update(:y).with(['y', 2]) 
    assert_equal 'a', @node[1].value        
  end

  define_method :"test update arg after arg :b" do      
    # res is a copy of node where child is update
    old_node = @node
    res = @node.insert(:before, 'a').code('call_me(7)') 
    assert_equal old_node, @node
    assert_not_equal old_node, res
  end
  
  define_method :"test update arg after arg :b" do        
    # res is node where child is removed (no copy)
    res = @node.insert!(:before, 'a').code('call_me(7)') 
    assert_equal @node, res    
  end

  define_method :"test update String argument with code Hash arg" do                           
    node = @code.find(:call, 'hello_world') do
      insert(:first, 'the first')      
    end       
    assert_equal 'the first', node[0].value
  end

  define_method :"test append is same as insert(:after)" do                           
    node = find(:call, 'hello_world') do
      # insert for all matching arguments
      where('a').append('the first')      
    end       
    assert_equal 'the first', node[0].value
  end

  define_method :"test prepend same as inser(:before)" do                           
    node = find(:call, 'hello_world') do
      # insert before first matching argument
      where('a')[0].prepend('the first')      
    end       
    assert_equal 'the first', node[0].value
  end

  define_method :"test update last matching String argument with new string" do                           
    node = find(:call, 'hello_world') do
      # insert on last matching argument
      where(:matches => /a/).last.insert(:after, 'the first')      
    end       
    assert_equal 'the first', node.last.value
  end

end