require File.dirname(__FILE__) + '/../../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{      
      class Monty < Abc::Blip 
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


  define_method :"test select Class that inherits from other Class and insert new method def" do                           
    @code.find(:class, 'Monty', :superclass => 'Abc::Blip') do |b|
      assert_equal Ruby::Class, b.class                                  
      b.insert(:after, "gem 'abc'")   
      puts b.to_ruby      
    end
  end 

  define_method :"test select Class that inherits from other Class and insert gem statements and a new method def" do                               
    @code.inside(:class, 'Monty', :superclass => 'Abc::Blip') do |b|
      gem_abc = b.insert(:after, "gem 'abc'")
      blip = b.insert(:after,"blip")
      gem_123 = gem_abc.insert(:after,"gem '123'")      
      gem_123.insert_comment(:after, "hello")      
      my_def = b.insert(:after, :code => method_code)      
      b.insert(:before, "gem '789'")
    end
  end
end