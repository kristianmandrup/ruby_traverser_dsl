require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{      
      def(axe, b)
        blip
        a = 0
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

  # use cases
  # don't allow the following inserted (or updated to) inside a method:
  # * class
  # * module
  # * method

  define_method :"test find gem statement inside group using DSL and then insert new gem statement" do                           
    src = %q{                 
group :test do
  gem 'ripper', :src => 'github' 
  gem 'blip'
end  
    }

    code = Ripper::RubyBuilder.build(src)                 

    code.find(:block, 'group', :args => [:test]) do |b|
      call_node = b.find(:call, 'gem', :args => ['ripper', {:src => 'github'}])
      assert_equal Ruby::Call, call_node.class
      b.insert(:after, "gem 'abc'")
      puts "mutated block:"
      puts b.to_ruby
    end       
  end
end