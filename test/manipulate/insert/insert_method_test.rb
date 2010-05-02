require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

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