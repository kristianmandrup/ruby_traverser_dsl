require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

    define_method :"test replace matching hash with new hash" do                           
      src = %q{                 
  group :test do
    gem 'kris', 2, :src => 'goody', 
  end  
      }

      code = Ripper::RubyBuilder.build(src)                 
      code.inside(:block, 'group', :args => [:test]) do |b|
        call_node = b.find(:call, 'gem', :args => ['kris'])
        assert_equal Ruby::Call, call_node.class

        call_node.update(:select => {:arg => {:src => 'goody'}} , :with_code => "{:src => 'unknown'}")
        call_node.replace(:arg => '#1' , :with_code => "{:src => 'known'}")

        puts b.to_ruby
      end       
    end  


end