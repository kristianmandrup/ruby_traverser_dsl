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

  define_method :"test find gem statement inside group using DSL and then replace symbol argument with hash argument" do                           
    src = %q{                 
group :test do
  gem 'ripper', :src
end  
    }

    code = Ripper::RubyBuilder.build(src)                 
    code.find(:block, 'group', :args => [:test]) do
      call_node = find(:call, 'gem', :args => ['ripper'])
      call_node.update(:select => {:arg => :src}, :with_code => "{:src => 'unknown'}")      
      puts to_ruby
    end       
  end  

  define_method :"test find gem statement inside group using DSL and then replace matching hash with new hash" do                           
    src = %q{                 
group :test do
  gem 'kris', 2, :src => 'goody', 
end  
    }

    code = Ripper::RubyBuilder.build(src)                 
    code.inside(:block, 'group', :args => [:test]) do |b|
      call_node = b.find(:call, 'gem', :args => ['kris'])
      assert_equal Ruby::Call, call_node.class
      # call_node.update(:select => {:arg => {:src => 'goody'}} , :with_code => "{:src => 'unknown'}")
      # call_node.replace(:arg => '#1' , :with_code => "{:src => 'known'}")
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

    code.find(:def, 'hello_world', :params => ['a']) do |b|
      ass_node = b.find(:assignment, 'my_var')
      assert_equal Ruby::Assignment, ass_node.class
      
      ass_node.update(:value => "3")      
      puts b.to_ruby
    end
  end  

  define_method :"test select Class that inherits from other Class and insert new method def" do                           
    src = %q{      
      class Monty < Abc::Blip 
      end 
    }
    code = Ripper::RubyBuilder.build(src)              
    code.find(:class, 'Monty', :superclass => 'Abc::Blip') do |b|
      assert_equal Ruby::Class, b.class                                  
      b.insert(:after, "gem 'abc'")   
      puts b.to_ruby      
    end
  end 
  
end