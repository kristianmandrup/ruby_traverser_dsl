require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test select Class that inherits from other Class and insert new method def" do                           
    src = %q{      
class Monty < Abc::Blip 
end 
    }
    code = Ripper::RubyBuilder.build(src)              
    code.inside_class('Monty', :superclass => 'Abc::Blip') do |b|
      assert_equal Ruby::Class, b.class                                  
      b.append_code("gem 'abc'")
      puts b.to_ruby      
    end
  end
end        
