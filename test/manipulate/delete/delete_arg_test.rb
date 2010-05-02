require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  # use cases
  # delete single arg, by matching position, name or "full value"
  # delete range og args
  # delete args using enumerator, fx reject!
  # delete all args    

  define_method :"test delete(:first) deletes first statement" do                           
    #
  end
end