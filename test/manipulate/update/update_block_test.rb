require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"update first statement within block" do                           
    src = %q{                 
      group 'ripper' do
        rap
      end
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:block, 'group').where('ripper') do
      # update first statement within block!
      first.update_with(:code => 'hello')     
    end       
    assert_equal 'hello', node[0].name      
  end

  define_method :"test update Integer argument with new Integer argument" do                           
    src = %q{                 
      sum 5, 7 do |s|
        puts s
      end
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:call, 'sum').where(:param, 's') do
      update(5).with(4)      
    end       
    assert_equal 4, node[0].value      
  end

  define_method :"test update Integer argument with new Integer argument" do                           
    src = %q{                 
      sum 5, 7 do |s,z|
        puts s
      end

      sum do |s|
        puts s + 2
      end

    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:block, 'sum').where(:only, :param, 's') do |b|
      b[0].update_with(:code => 'puts s + 3')      
    end       
    assert_equal 'puts s + 3', node[0].to_ruby      
  end

  define_method :"test :any where argument match (default)" do                           
    src = %q{                 
      sum 5 do
      end
      
      sum 5, :blip => :blap do |v, x|
      end
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:call, 'sum').where(:any, 5).last do
      update(:name => 'subtract')
      update(5).with(6)
      update(:param, :v).with(:vix)
    end       
    assert_equal 'subtract', node.name          
  end

  define_method :"test :any where argument match (default)" do                           
    src = %q{                 
      sum 5 do
      end
      
      sum 5, :blip => :blap do |v, x|
      end
    }

    code = Ripper::RubyBuilder.build(src)                 
    node = code.find(:call, 'sum').where(:any, 5).last do
      update(:param, :v).with(:vix)
    end       
    assert_equal 'vix', node.params[0].name          
  end

end