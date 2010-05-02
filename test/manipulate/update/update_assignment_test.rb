require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test find assignment in method definition and replace value of right side String value '3'" do                           
    src = %q{    
      def hello_world(a)
        my_var = 2
      end  
    }    

    code = Ripper::RubyBuilder.build(src)               

    node = code.find(:def, 'hello_world', :params => ['a']) do |b|
      assign_node = b.find(:assignment, 'my_var')
      assign_node.update(:value => '3')      
    end
    
    assert_equal '3', node[0].value
  end  

  define_method :"test find assignment in method definition and replace value of right side with Integer value 3" do                           
    src = %q{    
      def hello_world(a)
        my_var = 2
      end  
    }    

    code = Ripper::RubyBuilder.build(src)               

    node = code.find(:def, 'hello_world', :params => ['a']) do |b|
      assign_node = b.find(:assignment, 'my_var')
      assign_node.update(3)      
    end    
    assert_equal 3, node[0].value    
  end  
  
  define_method :"test find assignment in method definition and replace value variable name with 'my_other' " do                           
    src = %q{    
      def hello_world(a)
        my_var = 2
      end  
    }    

    code = Ripper::RubyBuilder.build(src)               

    node = code.find(:def, 'hello_world', :params => ['a']) do |b|
      assign_node = b.find(:assignment, 'my_var')
      assign_node.update(:name => 'my_other')      
    end    
    assert_equal 'my_other', node[0].name    
  end  
  
end
