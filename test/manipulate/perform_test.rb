require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{    
      hello_world 'hello', :b, 2
    }    
    code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
  end


  define_method :"test perform" do                           
    @node.perform do
      find(:arg, :_2).update_with('blip')
      update('hello').with('hi there!')
    end
  end
end