require File.dirname(__FILE__) + '/../../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper
  
  define_method :"test find String value argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find Integer value argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find Float value argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find Symbol value argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find Range value argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 

  
  define_method :"test find Call value argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 
  
end  
