require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"setup" do                           
    src = %q{                 
      group 'ripper', a, :k, 7
    }
        
    @code = Ripper::RubyBuilder.build(src)                   
    @node = code[0]
  end


  define_method :"update first statement within block" do                           
    @node.find(:block, 'group').where('ripper') do
      args.first.append(:code => 'hello')     
    end       
    assert_equal 'hello', node[0].name      
  end

  define_method :"test update Integer argument with new Integer argument" do                           
    @node.find(:call, 'sum').where(:param, 's') do
      args.prepend(4)      
    end       
    assert_equal 4, node[0].value      
  end


end