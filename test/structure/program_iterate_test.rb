require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase  
  include TestHelper

  define_method :"test iterate program instructions" do                           
    src = %q{    
      'xy' 
      2
      34.5
    }
    code = Ripper::RubyBuilder.build(src) 
    vals = code.map{|e| e.value }
    assert_equal ['xy', 2, 34.5] , vals
    assert_equal 'xy', code[0].value
    assert_equal 'xy', code.first.value
    assert_equal 34.5, code.last.value
        
  end 
end