require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  def setup
  end
    
  define_method :"test select Module with complex namespace" do                           
    src = %q{      
      module Xyz::Xxx::Blip
        2
      end    
    }
    
    code = Ripper::RubyBuilder.build(src)          
    module_node = code.find_module('Xyz::Xxx::Blip') 
    assert_equal Ruby::Module, module_node.class 
    # puts "module: #{module_node}" 
  end

  define_method :"test select Class with complex namespace" do                           
    src = %q{      
      class Abc::Bef::Monty 
      end 
    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find_class('Abc::Bef::Monty') 
    assert_equal Ruby::Class, clazz_node.class
    # puts "class: #{clazz_node}" 
  end


  define_method :"test select Class that inherits from other Class" do                           
    src = %q{      
      class Monty < Abc::Blip 
      end 
    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find_class('Monty', :superclass => 'Abc::Blip') 
    assert_equal Ruby::Class, clazz_node.class     
  end

  define_method :"test select block" do                           
    src = %q{ 
      my_block = 7     
      my_block do
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)              
    block_node = code.find_call('my_block')  
    assert_equal Ruby::Call, block_node.class
  end

  define_method :"test select block with args" do                           
    src = %q{  

      my_block :hello => 7 do
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find_call('my_block', :args => [{:hello => 7}]) 
    assert_equal Ruby::Call, block_node.class
  end

  define_method :"test select block with params" do                           
    src = %q{  

      my_block do |v|
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find_call('my_block', :block_params => ['v']) 
    assert_equal Ruby::Call, block_node.class
  end

  define_method :"test select block with multi element hash argument" do                           
    src = %q{  

      my_block :a => 7, b => 3 do |v|
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find_call('my_block', :args => [{:a => 7, 'b' => 3}]) 
    assert_equal Ruby::Call, block_node.class
  end

  define_method :"test select block with multi element array argument" do                           
    src = %q{  
  
      my_block ['a', 'b'] do |v|
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find_call('my_block', :args => [{:array =>['a', 'b']}]) 
    assert_equal Ruby::Call, block_node.class
  end

  define_method :"test select block with multi element array argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end

  define_method :"test select block with multi element array argument" do                           
    src = %q{    
      group :test do
        gem 'ripper', :src => 'github' 
      end
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find_call('group', :args => [:test], :block => true) 
    assert_equal Ruby::Call, block_node.class
#    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
#    assert_equal Ruby::Call, call_node.class
  end


  
end