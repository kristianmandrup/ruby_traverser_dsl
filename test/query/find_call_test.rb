require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test select call with matching hash association" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, 'ripper') 
    assert_equal Ruby::Call, call_node.class
  end

  define_method :"test select call with matching hash association" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, {:src => 'github'}) 
    call_node = code.find(:call, 'gem').where(:arg, :assoc => {:src => 'github'}) 
    assert_equal Ruby::Call, call_node.class
  end

  define_method :"test select call with matching hash association" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, :assoc_key => :src) 
    assert_equal Ruby::Call, call_node.class
  end

  define_method :"test select call with matching hash association" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, :assoc_value => 'github') 
    assert_equal Ruby::Call, call_node.class
  end

  define_method :"test select call with matching hash association" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, :_1).has(:assoc_value => 'github') 
    call_node = code.find(:call, 'gem').where(:arg, :pos => 1).has(:assoc_value => 'github') 
    assert_equal Ruby::Call, call_node.class
  end

  define_method :"test select call with matching hash association" do                           
    src = %q{    
      gem :src => 'github', 'ripper' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, :_2).has(:assoc_value => 'github') 
    assert_equal nil, call_node
  end


  define_method :"test select call with matching hash association" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end
    
end