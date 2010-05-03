require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{      
      hello :a => 'b', 'c' => :d, :e => {:x => 23}, :a => 7, :abc => /hello/      
    }
    @code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
  end


  define_method :"test replace matching hash with new hash using code" do                           
    src = %q{                 
      gem :src => 'goody'      
    }

    code = Ripper::RubyBuilder.build(src)                 
    call_node = @node.update(:src => 'goody'}.with_code("{:src => 'unknown'}")
    assert_equal 'unknown', call_node[0].first.value
  end  

  define_method :"test replace matching hash with new hash" do                           
    # translate hash assoc to code, then use with_code internally!
    call_node = @node.update(:src => 'goody'}.with(:src => 'unknown')
    assert_equal 'unknown', call_node[0].first.value
  end  

  define_method :"test replace matching hash with new comlex hash using code" do                           
    src = %q{                 
      gem :src => {:blap => 'goody'}      
    }

    code = Ripper::RubyBuilder.build(src)                 
    call_node = @node.update(:src => {:blap => 'goody'} }.with_code(":src => {:blip => 'unknown'}")
    assert_equal 'unknown', call_node[0].first.value[0].first.value
  end  


end