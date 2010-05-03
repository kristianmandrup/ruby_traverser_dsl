require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{      
      class Monty < Abc::Blip 
      end 
      
      class Hello
        rap
      end

      class Hello < Hi
        rap
      end
      
    }

    method_src = %q{
      def my_fun(axe)
      end
    }

    @method_code = Ripper::RubyBuilder.build(method_src)            
    @code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
  end


  define_method :"update class name" do                           
    src = %q{                 
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = @code.find(:class, 'Hello') do
      name = 'GoodBye'     
    end       
    assert_equal 'GoodBye', node.name      
  end

  define_method :"update superclass name" do                           
    src = %q{                 
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = @code.find(:class, 'Hello') do
      superclass = 'GoodBye'     
    end       
    assert_equal 'GoodBye', node.superclass.name      
  end

  
  define_method :"update first statement of class" do                           
    node = @code.find(:class, 'Hello') do
      first.update_with(:code => 'hello')     
    end       
    assert_equal 'hello', node[0].name      
  end  
  
  define_method :"update first statement of class (alternative)" do                           
    node = @code.find(:class, 'Hello') do
      first = parse_code('hello')     
    end       
    assert_equal 'hello', node[0].name      
  end  
end