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
    code.inside(:class, 'Monty', :superclass => 'Abc::Blip') do |b|
      assert_equal Ruby::Class, b.class                                  
      gem_abc = b.insert(:after, "gem 'abc'")
      blip = b.insert(:after,"blip")
      gem_123 = gem_abc.insert(:after,"gem '123'")      
      gem_123.insert_comment(:after, "hello")      
      my_def = b.insert(:after, def_src)      
      
      b.insert(:before, "gem '789'")
      puts b.to_ruby
    end
  end
end   
