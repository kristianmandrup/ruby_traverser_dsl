require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test find gem statement inside group using DSL and then insert new gem statement" do                           

    # Class
    # class Hello::Abc
    n.find(:id, Hello::Abc).update!(Hello::Xyz)
    # class Hello::Xyz

    # helo 1,2, :k => 'blap'    
    node.update(:arg, :_2).with('blip')
    # helo 1,2, 'blip'
    
    node.update(:key, :_2).with(:x)
    # helo 1,2, :x => 'blap'    
    node.update(:value, :_2).with('blip')
    # helo 1,2, :k => 'blip'    
    
    node.update(:arg, '#2').with('blip')
    node.update(:key, :k).with('blip')    
    node.update(:arg, :k).with_code(":k => 'hello'")    

    node.update(:key, :k).with(old_node.get(:key, :k))

    node.update(:key, :k).with do
      'blip'
    end

    node.perform do
      find(:arg, :_2).update(:key, :k).with('blip')
      update(:arg, 'hello').with('hi there!')
    end


    # update works same as find
    # update! works same as with

    # class MyMod::Abc < Blip::Blap
    n.find(:superclass, Blip::Blap).update!(Klip::Klop)
    # class MyMod::Abc < Klip::Klop

    # Module
    # module MyMod::Abc
    n.find(:id, MyMod::Abc).update!(MyMod::Xyz)
    # class MyMod::Xyz

    # Assignment
    # b = 7
    n.find(:id, 'b').update!('x')
    # x = 7

    # b = 7
    n.find(:value, 7).update!(32)
    # x = 32

    # chaining
    # b = 7
    n.find(:value, 7).update!(32).find(:id, 'b').update!('c')
    # c = 32

    # Method
    # def abc(a, b) ... end
    n.find(:id, 'abc').update!('xyz')
    # def xyz(a, b)

    # def abc(a, b) ... end
    n.find(:param, 'a').update!('file')
    # def abc(file, b)

    # Call
    # gem :src, 2
    n.find(:arg, :value => :src).update!(:value => :unknown)
    # gem :unknown, 2

    # gem :src => :blip, 2
    n.find(:arg, :key => :src).update!(:arg => :blap).delete!(:arg, 1)
    # gem :src => :blap

    # gem :src => 1..5, 3
    n.find(:arg, :key => :src, :value => 1..5).update! do
      "1..10"
    end

    # gem :src => 1..10, 3

    update should work on:
    * Ruby::Module, identifier
    * Ruby::Class, identifier 
    * Ruby::Assignment
     - identifier
     - value

    * Ruby::Call
     - identifier
     - param
     - block_param

    * Ruby::Method
     - identifier
     - param

    # delete argument
    node.find(:arg, :src).delete!

    # keyword
    node.find(:include, ModuleName).delete 
    node.insert(:include, ModuleName).delete 

    # keyword
    node.find(:require, 'mocha').delete! 
    node.insert(:require, 'mocha')
  end
end