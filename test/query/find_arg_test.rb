require File.dirname(__FILE__) + '/../../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper
  
  define_method :"test find String value argument" do                           
    src = %q{    
      gem 'rapper'
      gem 'ripper'
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, 'ripper') 
    call_node = code.find(:call, 'gem').where(:arg, :string => 'ripper') 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find Integer value argument" do                           
    src = %q{    
      gem 'ripper', 26
      gem 'ripper', 27
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, 27) 
    call_node2 = code.find(:call, 'gem').where(:arg, :int => 27)       
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find Float value argument" do                           
    src = %q{           
      gem 'ripper', 32
      gem 'ripper', 32.5
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, 32.5) 
    call_node = code.find(:call, 'gem').where(:arg, :float => 32.5) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find Symbol value argument" do                           
    src = %q{    
      gem 'ripper', :src
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, :src) 
    call_node = code.find(:call, 'gem').where(:arg, :symbol => :src) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find Range value argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, :src => 'github') 
    call_node = code.find(:call, 'gem').where(:arg, :assoc => {:src => 'github'}) 
    assert_equal Ruby::Call, call_node.class
  end 

  
  define_method :"test find Call value argument" do                           
    src = %q{    
      gem 'ripper', hello

      def hello        
      end
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, :call => {:name => 'hello'}) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find call with very specific Method Call argument" do                           
    src = %q{    
      gem 'ripper', hello(5,2)

      def hello        
      end
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, :call => {:name => 'hello', :args => [5,2]} ) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find call what has two specific Integer value arguments" do                           
    src = %q{    
      gem 'ripper', 27
      gem 'ripper', 27, 28
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, 27).and_where(:arg, 28) 
    call_node = code.find(:call, 'gem').where(:arg, :int => 27).and_where(:arg, :int => 28) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find call what has specific Float and Integer value arguments" do                           
    src = %q{    
      gem 'ripper', 27.5
      gem 'ripper', 27.5, 28
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, 27.5).and_where(:arg, 28) 
    call_node = code.find(:call, 'gem').where(:arg, :float => 27.5).and_where(:arg, :int => 28) 
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find call with a 'true' argument" do                           
    src = %q{    
      gem 'ripper', false
      gem 'ripper', true
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, true)
    call_node = code.find(:call, 'gem').where(:arg, :true)
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find call with a 'false' argument" do                           
    src = %q{    
      gem 'ripper', nil
      gem 'ripper', false
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, false)
    call_node = code.find(:call, 'gem').where(:arg, :false)
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find call with a 'nil' argument" do                           
    src = %q{    
      gem 'ripper', false
      gem 'ripper', nil
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, nil)
    call_node = code.find(:call, 'gem').where(:arg, :nil)
    assert_equal Ruby::Call, call_node.class
  end 

  define_method :"test find call with a Range argument" do                           
    src = %q{    
      gem 'ripper', false
      gem 'ripper', 1..5
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find(:call, 'gem').where(:arg, 1..5)
    call_node2 = code.find(:call, 'gem').where(:arg, :range => 1..5)
    assert_equal Ruby::Call, call_node.class
  end 

  
end  
