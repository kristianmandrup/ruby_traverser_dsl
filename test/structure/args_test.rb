require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do
    src = %q{                 
gem 'ripper', 7, TraversalTest, :blip
    }

    code = Ripper::RubyBuilder.build(src)  
    @node = code[0]    
  end

  define_method :"test call name" do                           
    assert_equal 'gem', @node.name    
  end


  define_method :"test argument which is itself a call with an argument" do                           
    src = %q{                 
abc(pde(2), 7)

def pde(num)
  32
end
    }
    code = Ripper::RubyBuilder.build(src)  
    @node = code[0]    
    assert_equal 'pde(2)', @node.first.value    
  end

  define_method :"test args_list not empty" do                           
    assert_equal false, @node.empty?    
  end

  define_method :"test args_list iterate" do                           
    assert_equal ['ripper', 7, TraversalTest, :blip] , @node.map{|e| e.value }
  end    

  define_method :"test args position value" do                           
    assert_equal 'ripper', @node[0].value
  end    

  define_method :"test args first position value" do                           
    assert_equal 'ripper', @node.first.value
  end    

  define_method :"test args last position value" do                           
    assert_equal :blip, @node.last.value
  end

  define_method :"test args value from range positioning" do                           
    assert_equal ['ripper',7], @node[0..1].value      
  end   
end

