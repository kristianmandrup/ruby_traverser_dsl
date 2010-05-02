require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test select block with symbol argument" do
    src = %q{    
      group :test do
        gem 'ripper', :src => 'github' 
      end
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find(:block, 'group').where(:arg, :test)
    assert_equal Ruby::Call, block_node.class
  end


  define_method :"test select block" do                           
    src = %q{ 
      my_block(7)     
      my_block do
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)              
    block_node = code.find(:block, 'my_block')  
    assert_equal Ruby::Call, block_node.class
  end

  define_method :"test select block with args" do                           
    src = %q{  
      my_block :hello => 7
      my_block :hello => 7 do
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find(:block, 'my_block').where(:arg, {:hello => 7}) 
    assert_equal Ruby::Call, block_node.class
  end

  define_method :"test select block with params" do                           
    src = %q{  
      my_block do |v, k|
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find(:block, 'my_block').where(:params, ['v', 'k']) 
    assert_equal Ruby::Call, block_node.class
  end

  define_method :"test select block with multi element hash argument" do                           
    src = %q{  

      my_block hello, :a => 7 do |v|
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find(:block, 'my_block').where(:args, ['hello', {:a => 7}]).and_where(:param, 'v')
    assert_equal Ruby::Call, block_node.class
  end

  define_method :"test select block with multi element array argument" do                           
    src = %q{  

      my_block ['a', 'b'] do |v|
        1
      end 
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find(:block, 'my_block').where(:arg, :array => ['a', 'b'] ) 
    assert_equal Ruby::Call, block_node.class
  end
end