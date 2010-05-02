require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"update class name" do                           
    src = %q{                 
      class Hello
        rap
      end
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:class, 'Hello') do
      name = 'GoodBye'     
    end       
    assert_equal 'GoodBye', node.name      
  end

  define_method :"update superclass name" do                           
    src = %q{                 
      class Hello < Hi
        rap
      end
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:class, 'Hello') do
      superclass = 'GoodBye'     
    end       
    assert_equal 'GoodBye', node.superclass.name      
  end

  
  define_method :"update first statement of class" do                           
    src = %q{                 
      class Hello
        rap
      end
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:class, 'Hello') do
      first.update_with(:code => 'hello')     
    end       
    assert_equal 'hello', node[0].name      
  end  
  
  define_method :"update first statement of class (alternative)" do                           
    src = %q{                 
      class Hello
        rap
      end
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:class, 'Hello') do
      first = parse_code('hello')     
    end       
    assert_equal 'hello', node[0].name      
  end  
end