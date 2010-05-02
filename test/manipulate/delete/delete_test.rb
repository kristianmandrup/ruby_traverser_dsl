require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test delete(:first) deletes first statement" do                           
  end

  define_method :"test delete more..." do                               
    # delete argument
    node.find(:arg, :src).delete!

    # keyword
    node.find(:include, ModuleName).delete 
    node.insert(:include, ModuleName).delete 

    # keyword
    node.find(:require, 'mocha').delete! 
    node.insert(:require, 'mocha')    
  end


  define_method :"test find assignment in method definition and replace value of right side" do                           
    src = %q{    
      def hello_world(a)
        my_var = 2
      end  
    }    
        
    code = Ripper::RubyBuilder.build(src)               

    code.inside(:def, 'hello_world', :params => ['a']) do |b|
      # call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}], :verbose => true)
      ass_node = b.find(:assignment, 'my_var')
      assert_equal Ruby::Assignment, ass_node.class    
      ass_node.delete
      puts b.to_ruby
    end
  end
end