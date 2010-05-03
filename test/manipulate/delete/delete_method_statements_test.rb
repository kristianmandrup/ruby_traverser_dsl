require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{    
      def my_method(:a, 'b', 2)
        a = 3
        call_me
        blip
      end
    }
    code = Ripper::RubyBuilder.build(src)                 
    @node = code[0]        
    @statements = @node.statements
  end

  define_method :"delete first statement within method" do                           
    @node.first.delete(:name, 'a')     
    assert_equal 'call_me', @statements[0].name      
  end

  define_method :"delete last statement within method" do                           
    assert_equal 'call_me', @statements.last.name      
    @statements.last.delete(:name, 'call_me')     
    assert_equal 'a', @statements.last.name      
  end

  define_method :"delete last statement within method (alternative)" do                           
    assert_equal 'call_me', @statements.last.name      
    @node.delete(:statement, :last)     
    assert_equal 'a', @statements.last.name      
  end

  define_method :"delete all statements within method" do                           
    assert_equal 'call_me', @node.last.name      
    @node.statements.delete!
    assert_equal 'a', @node.last.name      
  end
end