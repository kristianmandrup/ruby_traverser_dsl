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
  
  define_method :"test update arg before arg :b" do
    res = @node.before(:arg, :b).update.with('y') 
    assert_equal 'y', @node.first.value
  end

  define_method :"test update arg after arg :b" do
    res = @node.after(:arg, :b).update_with('y') 
    assert_equal 'y', @node.last.value
  end

  define_method :"test update arg after arg :b" do      
    res = node.after(:arg, 'a').update_with(:code => 'call_me(5)') 
    assert_equal 'call_me(5)', @node[1].value.to_ruby    
  end
  
  define_method :"test before :arg update_with " do        
    my_other_node = node.find(:arg, 'a')
    res = node.before(:arg, 2).update_with(my_other_node) 
    assert_equal 'a', @node[1].value    
  end

  define_method :"test update arg after arg :b" do      
    res = node.args.before(:x).update(:y).with(['y', 2]) 
    assert_equal 'a', @node[1].value        
  end
  define_method :"test update arg after arg :b" do      
    # res is a copy of node where child is update
    res = node.update(child select).with(value) 
  end
  
  define_method :"test update arg after arg :b" do        
    # res is node where child is removed (no copy)
    res = node.update!(child select)
  end

  define_method :"test update String argument with code Hash arg" do                           
    node = find(:call, 'hello_world') do
      update(:first, 'the first')      
    end       
    assert_equal 'the first', node[0].value
  end

  define_method :"test update all matching String arguments with new string" do                           
    node = find(:call, 'hello_world') do
      # updates all matching arguments
      where('a').update_with('the first')      
    end       
    assert_equal 'the first', node[0].value
  end

  define_method :"test update first matching String argument with new string" do                           
    node = find(:call, 'hello_world') do
      # updates first matching argument
      where('a')[0].update_with('the first')      
    end       
    assert_equal 'the first', node[0].value
  end

  define_method :"test update last matching String argument with new string" do                           
    node = find(:call, 'hello_world') do
      # updates last matching argument
      where(:matches => /a/).last.update_with('the first')      
    end       
    assert_equal 'the first', node.last.value
  end

  define_method :"test update String argument with code Hash arg using block and last" do                           
    src = %q{                 
      gem 'number 2'
    }

    code = Ripper::RubyBuilder.build(src)                 
    find(:call, 'gem') do
      last.update_with('the last')              
    end       
  end


  define_method :"test update Symbol argument with code Hash arg" do                           
    src = %q{                 
      hello :args
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = find(:call, 'hello').where(:arg => :args)
    node.update(:src).with(:code => "{:src => 'unknown'}") do     
      puts to_ruby
    end       
  end

  define_method :"test update Symbol argument with code Hash arg" do                           
    src = %q{                 
      hello :args => 32
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = find(:call, 'hello').where(:arg => {:args => 32})
    node.update(:src).with(:code => "{:src => 'unknown'}") do     
      puts to_ruby
    end       
  end

  define_method :"test update Symbol argument with code Hash arg" do                           
    src = %q{                 
      hello :args => 32
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = find(:call, 'hello').where(:args => 32)
    assert_nil node, "method call does not have an argument 32"
  end

end