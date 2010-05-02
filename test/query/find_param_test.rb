require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test find param" do                           
    src = %q{    
      def hello_world(a)
      end  
    }
    code = Ripper::RubyBuilder.build(src)               
    code.inside(:method, 'hello_world').where(:param, 'a') do |meth|      
      assert_equal Ruby::Method, meth.class
    end
  end

  define_method :"test find method with no params" do                           
    src = %q{    
      def hello_world(a)
      end  

      def hello_world
        puts "helloo!"
      end  
    }
    code = Ripper::RubyBuilder.build(src)               
    code.inside(:method, 'hello_world').where(:no_param) do |meth|      
      assert_equal Ruby::Method, meth.class
    end
  end

  define_method :"test find method with default value param" do                           
    src = %q{    
      def hello_world(a = 32)
      end  

      def hello_world
        puts "helloo!"
      end  
    }
    code = Ripper::RubyBuilder.build(src)               
    code.inside(:method, 'hello_world').where(:param, :assoc => {:a => 32}) do |meth|      
      assert_equal Ruby::Method, meth.class
    end
  end

  define_method :"test find method with default value param" do                           
    src = %q{    
      def hello_world(*a)
      end  

      def hello_world
        puts "helloo!"
      end  
    }
    code = Ripper::RubyBuilder.build(src)               
    code.inside(:method, 'hello_world').where(:star_param, :a) do |meth|      
      assert_equal Ruby::Method, meth.class
    end
  end


end