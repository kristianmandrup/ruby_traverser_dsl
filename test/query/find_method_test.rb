require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test find method definition" do                           
    src = %q{    
      def hello_world(a)
      end  
    }
    code = Ripper::RubyBuilder.build(src)               
    code.inside(:method, 'hello_world') do |meth|      
      assert_equal Ruby::Method, meth.class
    end
  end

  define_method :"test find variabel in method definition" do                           
    src = %q{    
      def hello_world(a)
        my_var
      end  
    }    
        
    code = Ripper::RubyBuilder.build(src)               
    code.inside(:method, 'hello_world').where(:param, 'a') do |b|
      var_node = b.find(:variable, 'my_var')
      assert_equal Ruby::Variable, var_node.class
    end
  end  

  define_method :"test find variabel in method definition" do                           
    src = %q{    
      def hello_world(a)
        my_var
        32
      end  
    }    
        
    code = Ripper::RubyBuilder.build(src)               
    code.inside(:method, 'hello_world').where(:param, 'a') do |meth|
      assert_equal 32, meth.body[1].value
    end
  end  


  define_method :"test find assignment in method definition" do                           
    src = %q{    
      def hello_world(a, b)
        3
        my_var = 2
        puts my_var
      end  
    }    
        
    code = Ripper::RubyBuilder.build(src)               
    code.inside(:method, 'hello_world').where(:params => ['a', 'b']) do |b|
      ass_node = b.find(:assignment, 'my_var')
      assert_equal Ruby::Assignment, ass_node.class
      puts ass_node.to_ruby
    end
  end
end