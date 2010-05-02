require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test select While" do                           
    src = %q{      
      while a > 1
        puts "hello"
      end 

      while b < 2
        puts "bye"
      end 

    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find(:while).first
    assert_equal Ruby::Class, clazz_node.class     
  end

  define_method :"test select While" do                           
    src = %q{      
      until a > 1
        puts "hello"
        a = a + 1
      end 

      until true
        puts "bye"
      end 

    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find(:until).last
    assert_equal Ruby::Class, clazz_node.class     
  end
