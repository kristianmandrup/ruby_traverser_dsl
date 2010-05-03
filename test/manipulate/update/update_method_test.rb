require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{                 
      def hello
        puts "hi"
      end
    }
    @code = Ripper::RubyBuilder.build(src)                 
    @node = code[0].update(:name).with('greeting')
  end


  define_method :"test update name of method" do                           
    @node.update(:name).with('greeting')
    assert_equal 'greeting', node.name
  end

  define_method :"test update first argument of method" do                           
    @node.update('a').with('str')
    assert_equal 'a', node[0].value
  end

  define_method :"test update first argument of method" do                           
    @node.update(:pos => 1).with('str')
    assert_equal 'a', node[0].value
  end


  define_method :"test update default value of first argument of method" do                           
    @node.update(:pos => 1) do |n|
      n.default_value = parse_code('{}')
    end
    assert_equal '{}', node[0].default_value
  end

end