require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{    
      my_block :a, 'b', 2 do |d, e, f|        
        a = 3
        call_me
      end
    }
    code = Ripper::RubyBuilder.build(src)                 
    @node = code[0]        
    @statements = @node.statements
  end

  define_method :"delete first statement within block" do                           
    @@statements.first.delete(:name, 'a')     
    assert_equal 'call_me', @statements[0].name      
  end

  define_method :"delete last statement within block" do                           
    assert_equal 'call_me', @statements.last.name      
    @statements.last.delete(:name, 'call_me')     
    assert_equal 'a', @statements.last.name      
  end

  define_method :"do NOT delete last statement if NOT matching" do                           
    assert_equal 'call_me', @statements.last.name      
    res = @statements.last.delete(:name, 'call_me_not')     
    assert_equal 'call_me', @statements.last.name      
    assert_equal nil, res
  end

  define_method :"return nil if could NOT delete statement" do                           
    res = @statements.last.delete(:name, 'call_me_not')     
    assert_equal nil, res
  end

  define_method :"return node deleted from if could NOT delete statement" do                           
    res = @statements.last.delete(:name, 'call_me_not')     
    assert_equal @statements, res
  end

  define_method :"delete last statement within block (alternative)" do                           
    assert_equal 'call_me', @statements.last.name      
    @node.delete(:statement, :last)     
    assert_equal 'a', @statements.last.name      
  end

  define_method :"delete all statements within block" do                           
    assert_equal 'call_me', @statements.last.name      
    @statements.delete!
    assert_equal 'a', @statements.last.name      
  end
  
end