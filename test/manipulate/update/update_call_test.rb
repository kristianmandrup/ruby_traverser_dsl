require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test update String argument with code Hash arg" do                           
    src = %q{                 
      gem 'ripper'
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:call, 'gem').where(:arg, 'ripper') do
      update(:name).with('gemsify')      
    end       
    assert_equal 'gemsify', node.name      
  end

  define_method :"test update Integer argument with new Integer argument" do                           
    src = %q{                 
      sum 5, 7
    }

    code = Ripper::RubyBuilder.build(src)                 
    # by default search for matches in arguments list! 
    # no reason to specify :arg
    node = code.find(:call, 'sum').where(5, 7) do
      update(5).with(4)      
    end       
    assert_equal 4, node[0].value      
  end

  define_method :"test update Symbol argument with new Symbol argument" do                           
    src = %q{                 
      sum 5, :blip
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:call, 'sum').where(:blip) do
      update(:blip).with(:blap)      
    end       
    assert_equal 4, node[0].value      
  end

  define_method :"test update Hash argument with new Hash argument" do                           
    src = %q{                 
      sum 5, :blip => :blap
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:call, 'sum').where(5) do
      update(:blip => :blap).with(:blap => :blip)      
    end       
    assert_equal :blap => :blip, node[1].value      
  end

  define_method :"test :only where exact argument match" do                           
    src = %q{                 
      sum 5
      sum 5, :blip => :blap
    }

    code = Ripper::RubyBuilder.build(src)                 
    assert_raise RuntimeError do
      node = code.find(:call, 'sum').where(:only, 5) do
        update(:blip => :blap)
      end       
    end
  end

  define_method :"test :any where argument match (default)" do                           
    src = %q{                 
      sum 5
      sum 5, :blip => :blap
    }

    code = Ripper::RubyBuilder.build(src)                 
    assert_raise RuntimeError do
      node = code.find(:call, 'sum').where(:any, 5).last do
        update(:blip => :blap)
      end       
    end
  end


end