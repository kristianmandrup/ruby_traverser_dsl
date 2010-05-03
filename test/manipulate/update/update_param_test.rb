require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{    
      hello_world 'a', :b, 2, 'a', 'ab'
    }    

  define_method :"setup" do                           
    src = %q{                 
      def hello
        puts "hi"
      end
    
      sum 5, 7 do |s,z|
        puts s
      end    
    }
    @code = Ripper::RubyBuilder.build(src)                 
    @node = code[0].update(:name).with('greeting')
  end
end