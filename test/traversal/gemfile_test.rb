require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test select block with multi element array argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end
  
  define_method :"test find gem statement inside group" do                           
    src = %q{    
      group :test do
        gem 'ripper', :src => 'github' 
      end
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find_call('group', :args => [:test], :block => true) 
    assert_equal Ruby::Call, block_node.class
    call_node = block_node.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
    # puts call_node.to_ruby
  end  
  
  define_method :"test find gem statement inside group using better DSL" do                           
    src = %q{    
      gem 'ripper', :src => 'github', :blip => 'blap'       
      group :test do
        gem 'ripper', :src => 'github' 
      end
  
    }
    code = Ripper::RubyBuilder.build(src)              
    code.inside_block('group', :args => [:test]) do |b|
      call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}])
      assert_equal Ruby::Call, call_node.class
      puts call_node.to_ruby
    end
  end
  
  
  define_method :"test find method definition" do                           
    src = %q{    
      def hello_world(b)
        3
      end
  
      def hello_world(a)
        gem 'ripper', :src => 'github' 
      end
  
    }
    code = Ripper::RubyBuilder.build(src)               
    # def_node = code.find_def('hello_world', :params => ['a'])
    code.inside_def('hello_world', :params => ['a']) do |b|
      call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}])
      assert_equal Ruby::Call, call_node.class
      puts call_node.to_ruby
    end
  end 

  
end