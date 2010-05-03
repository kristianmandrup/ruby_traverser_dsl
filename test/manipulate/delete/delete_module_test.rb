require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{    
      module Hello
        module GoodBye
          a = 3
          call_me

          class Hello < Hi
            a = 2
            call_me!        
          end
          
        end
      end
      
      module Bye
        blip 
        blap
      end

    }    
        
    code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
    @node2 = code[1]    
  end

  define_method :"test delete first module" do
    @node.delete!
    assert_equal 'Bye', @code[0].name    
  end

  define_method :"test delete module within module to make module empty" do
    @node.find(:module, 'GoodBye').delete!
    assert @node[0].statements.empty?        
  end

  define_method :"test delete first statement in module" do
    goodbye = @node.first
    goodbye.first.delete!
    assert_equal 'call_me', @goodbye[0].name    
  end

  define_method :"test delete second statement in module" do
    @node.statements[1].delete!
    assert_equal 'Hello', @node.statements[1].name    
  end

  define_method :"test NOT delete module NOT matching name" do
    @node.delete!(:name, 'Hi::Again')
    assert_equal 'Hello', @node.name    
  end

  define_method :"test NOT delete module NOT matching name" do
    res = @node.delete!(:name, 'Hi::Again')
    assert_nil res
  end

  define_method :"test node deleted from returned on successful child node delete" do
    res = @node.first.delete!
    assert @node, res
  end

  define_method :"test true returned on successful delete" do
    res = @node.delete!
    assert_equal true, res
  end

end