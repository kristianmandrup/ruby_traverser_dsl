require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{    
      class Hello::Captain < Hi::There
        a = 3
        call_me
      end

      class Hello < Hi
        a = 2
        call_me!        
      end
    }    
        
    code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
  end

  define_method :"test delete first class" do
    @node.delete!
    assert_equal 'Hello', @node[0].name    
  end

  define_method :"test delete last class" do
    code.last.delete!
    assert_equal 'Hello::Captain', @node[0].name    
  end

  define_method :"test delete superclass" do
    @node.delete!(:superclass)
    assert_equal nil, @node[0].superclass    
  end

  define_method :"test delete superclass matching name" do
    @node.delete!(:superclass, 'Hi::There')
    assert_equal 'Hello::Captain', @node[0].name    
  end

  define_method :"test NOT delete superclass NOT matching name" do
    @node.delete!(:superclass, 'Hi::Again')
    assert_equal 'Hi::There', @node[0].superclass    
  end

  define_method :"test delete second statement" do
    @node.statements[1].delete!()
  end

  define_method :"test delete second statement (alternative)" do
    @node.delete!(:statement, :pos => 2)
  end

end