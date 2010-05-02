require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test perform" do                           

    node.perform do
      find(:arg, :_2).update(:key, :k).with('blip')
      update(:arg, 'hello').with('hi there!')
    end
  end

  define_method :"test update!" do                           
    # class MyMod::Abc < Blip::Blap
    n.find(:superclass, 'Blip::Blap').update!('Klip::Klop')
    # class MyMod::Abc < Klip::Klop
  end

  define_method :"test update! assignment variable name" do                           
    # Assignment
    # b = 7
    n.find(:var, 'b').update!('x')
    # x = 7
  end

  define_method :"test update! assignment value" do                           
    # b = 7
    n.find(:value, 7).update!(32)
    # x = 32
  end
  
  define_method :"test chaning" do                             
    # chaining
    # b = 7
     chain = n.find(:value, 7).update!(32)
     chain.find(:id, 'b').update!('c')
    # c = 32
  end

  define_method :"test block chaning" do                             
    # chaining
    # b = 7
     chain = n.find(:value, 7).update!(32) do |chain|
       chain.find(:id, 'b').update!('c')     
     end
    # c = 32
  end

  define_method :"test block chaning w implicit context" do                             
    # chaining
    # b = 7
     chain = n.find(:value, 7).update!(32) do
       find(:id, 'b').update!('c')     
     end
    # c = 32
  end

  define_method :"test more..." do                               
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
  end

end