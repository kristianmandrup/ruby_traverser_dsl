require File.dirname(__FILE__) + '/../../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper
  
  define_method :"test find hash argument by key" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find hash argument by value" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find hash argument by certain key having certain value" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find all hash arguments that have the same value" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 
end  
