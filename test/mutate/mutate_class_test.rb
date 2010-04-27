require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test select Class that inherits from other Class and insert gem statements and a new method def" do                           
    src = %q{  class Monty < Abc::Blip 
  end}
    
    def_src = %q{
def my_fun
end}

    def_code = Ripper::RubyBuilder.build(def_src)    
    code = Ripper::RubyBuilder.build(src)              
    code.inside_class('Monty', :superclass => 'Abc::Blip') do |b|
      assert_equal Ruby::Class, b.class                                  
      gem_call = b.append_code("gem 'abc'")
      gem_123 = gem_call.append_code("gem '123'")      
      gem_123.append_comment("hello")      
      b.append_code(def_src)      
      puts b.to_ruby
    end
  end
end   
