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
    
    code.inside_block('group', :args => [:test]) do |b|
      call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}])
      assert_equal Ruby::Call, call_node.class
      b.append_code("gem 'abc'")
      puts "mutated block:"
      puts b.to_ruby
    end       
  end  

  define_method :"test find gem statement inside group using DSL and then replace symbol argument with hash argument" do                           
    src = %q{                 
group :test do
  gem 'ripper', :src
end  
    }

    code = Ripper::RubyBuilder.build(src)                 
    code.inside_block('group', :args => [:test]) do |b|
      call_node = b.find_call('gem', :args => ['ripper'])
      assert_equal Ruby::Call, call_node.class

      # call_node.replace(:arg => 'ripper', :replace_arg => 'rapper')
      # call_node.replace(:arg => '#0', :replace_arg => 'rapper')
      call_node.replace(:arg => :src , :replace_code => "{:src => 'unknown'}")
      # 
      puts "mutated block:"
      # puts b.to_yaml
      puts b.to_ruby
    end       
  end  

  define_method :"test find gem statement inside group using DSL and then replace matching hash with new hash" do                           
    src = %q{                 
group :test do
  gem 'ripper', :src => 'blip'
end  
    }

    code = Ripper::RubyBuilder.build(src)                 
    code.inside_block('group', :args => [:test]) do |b|
      call_node = b.find_call('gem', :args => ['ripper'])
      assert_equal Ruby::Call, call_node.class

      # call_node.replace(:arg => 'ripper', :replace_arg => 'rapper')
      # call_node.replace(:arg => '#0', :replace_arg => 'rapper')
      call_node.replace(:arg => {:src => 'blip'} , :replace_code => "{:src => 'unknown'}")
      # 
      puts "mutated block:"
      # puts b.to_yaml
      puts b.to_ruby
    end       
  end  
   
  define_method :"test find assignment in method definition and replace value of right side" do                           
    src = %q{    
      def hello_world(a)
        my_var = 2
      end  
    }    
          
    code = Ripper::RubyBuilder.build(src)               

    code.inside_def('hello_world', :params => ['a']) do |b|
      # call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}], :verbose => true)
      call_node = b.find_assignment('my_var')
      assert_equal Ruby::Assignment, call_node.class
      
      call_node.replace(:value => "3")      
      puts b.to_ruby
    end
  end  
 

 
  
end