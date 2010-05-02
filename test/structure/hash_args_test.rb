require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do
    src = %q{                 
gem 'blip',:b => {:c => 2}, :x => 3, :k => {:h => 2} 
    }

    code = Ripper::RubyBuilder.build(src)  
    @node = code[0]  
  end

  define_method :"test get first hash assoc key" do                           
   assert_equal :x, @node[1].hash_assoc(1).name   
  end

  define_method :"test get first hash assoc value" do                           
   assert_equal 3, @node[1].hash_assoc(1).value.value   
  end

  define_method :"test get second hash assoc value which is a hash itself" do                           
   assert_equal Ruby::Hash, @node[1].hash_assoc(2).value.class   
  end

  define_method :"test get second hash assoc value which is a hash itself and find first key of this hash" do                           
   assert_equal :h, @node[1].hash_assoc(2).value.hash_assoc(0).name   
  end

end