require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase  
  include TestHelper

  define_method :"test handle Empty program" do                           
    src = %q{    
    }
    code = Ripper::RubyBuilder.build(src) 
    assert_equal true , code.empty?
  end 
  
  define_method :"test find Const value" do                           
    src = %q{    
      TraversalTest 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]                  
    assert_equal 'TraversalTest', node.str_val
    assert_equal TraversalTest, node.value
  end 
  
  define_method :"test find String value" do                           
    src = %q{    
      'xy' 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]
    assert_equal 'xy', node.value
  end 

  define_method :"test find True value" do                           
    src = %q{    
      true 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]
    assert_equal true, node.value
  end 

  define_method :"test find False value" do                           
    src = %q{    
      false 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]
    assert_equal false, node.value
  end 

  define_method :"test find Nil value" do                           
    src = %q{    
      nil 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]
    assert_equal nil, node.value
  end 


  define_method :"test find Integer value" do                           
    src = %q{    
      27 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]                  
    assert_equal 27, node.value
    assert_equal '27', node.str_val
  end 
  
  define_method :"test find Float value" do                           
    src = %q{    
      27.5 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]                  
    assert_equal 27.5, node.value
    assert_equal '27.5', node.str_val
  end 
  
  define_method :"test find Float value" do                           
    src = %q{    
      27.5 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]                  
    assert_equal 27.5, node.value
    assert_equal '27.5', node.str_val
  end 
  
  define_method :"test find Regexp value" do                           
    src = %q{    
      /abc/ 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]                  
    assert_equal 'abc', node.value
    assert_equal /abc/, node.to_regexp
  end 
  
  
  define_method :"test find Range value" do                           
    src = %q{    
      1..5 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]                  
    assert_equal 1..5, node.value
    assert_equal '1..5', node.str_val
  end 
  
  define_method :"test find Range start" do                           
    src = %q{    
      1..5 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]                  
    assert_equal 1, node.first
    assert_equal 5, node.last
  end 
  
  define_method :"test find Range end" do                           
    src = %q{    
      1..5 
    }
    code = Ripper::RubyBuilder.build(src) 
    node = code[0]
    assert_equal 5, node.last
  end 
        

  
end