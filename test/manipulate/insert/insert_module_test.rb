require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{      
      module Monty::Python
        class Blip
          hello
        end
      end 
      
      module Monty
        blap
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


  define_method :"test find gem statement inside group using DSL and then insert new gem statement" do                           
    @node.statements.after("gem 'abc'").insert('blip').insert('blap').insert('blop', 'slop')
    assert true
  end
end