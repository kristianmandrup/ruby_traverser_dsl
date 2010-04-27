require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

#   define_method :"test find gem statement inside group using DSL and then insert new gem statement" do                           
#     src = %q{                 
# group :test do
#   gem 'ripper', :src => 'github' 
#   gem 'blip'
# end  
#     }
#     
#     code = Ripper::RubyBuilder.build(src)                 
#     
#     code.inside_block('group', :args => [:test]) do |b|
#       call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}])
#       assert_equal Ruby::Call, call_node.class
# 
#       puts "add new element for gem code"
#       b.append_code("gem 'abc'")
#       # 
#       puts "mutated block:"
#       # puts b.to_yaml
#       puts b.to_ruby
#     end       
#   end  

  define_method :"test find gem statement inside group using DSL and then insert new gem statement" do                           
    src = %q{                 
group :test do
  gem 'ripper', :src => 'github' 
  gem 'blip'
end  
    }


    code = Ripper::RubyBuilder.build(src)                 

    code.inside_block('group', :args => [:test]) do |b|
      call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}])
      assert_equal Ruby::Call, call_node.class
      # assert_equal 'gem', call_node.i
      # puts call_node.to_yaml

      puts "add new element for gem code"
      call_node.replace(:arg => 'ripper', :replace_arg => 'rapper')
      # 
      puts "mutated block:"
      # puts b.to_yaml
      puts b.to_ruby
    end       
  end  
 
  
end