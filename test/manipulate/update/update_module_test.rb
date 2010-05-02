require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"update module name" do                           
    src = %q{                 
      module Hello
        rap
      end
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:module, 'Hello') do
      name = 'GoodBye'     
    end       
    assert_equal 'GoodBye', node.name      
  end
end