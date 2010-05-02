require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

    define_method :"test update String argument with code Hash arg" do                           
      src = %q{                 
        gem 'number 2'
      }

      code = Ripper::RubyBuilder.build(src)                 
      node = find(:call, 'gem') do
        update(:first).with('the first')      
      end       
      assert_equal 'the first', node[0].value
    end

    define_method :"test update String argument with code Hash arg" do                           
      src = %q{                 
        gem 'number 2'
      }

      code = Ripper::RubyBuilder.build(src)                 
      find(:call, 'gem') do
        update(:arg, :last).with('the last')              
      end       
    end


    define_method :"test update Symbol argument with code Hash arg" do                           
      src = %q{                 
        hello :src
      }

      code = Ripper::RubyBuilder.build(src)                 
      node = find(:call, 'hello').where(:arg, :src)
      node.update(:arg, :src).with(:code => "{:src => 'unknown'}")      
        puts to_ruby
      end       
    end



    define_method :"test find gem statement inside group using DSL and then replace symbol argument with hash argument" do                           
      src = %q{                 
  group :test do
    gem 'ripper', :src
  end  
      }

      code = Ripper::RubyBuilder.build(src)                 
      code.find(:block, 'group', :args => [:test]) do
        call_node = find(:call, 'gem', :args => ['ripper'])
        call_node.update(:arg, :src).with(:code => "{:src => 'unknown'}")      
        puts to_ruby
      end       
    end


  
end