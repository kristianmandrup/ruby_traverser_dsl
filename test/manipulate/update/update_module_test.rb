require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{                 
      module Hello
        rap
      end
    }
    @code = Ripper::RubyBuilder.build(src)                 
    @node = code[0].update(:name).with('greeting')
  end


  define_method :"update module name" do                           
    @node.find(:module, 'Hello') do
      name = 'GoodBye'     
    end       
    assert_equal 'GoodBye', node.name      
  end
end