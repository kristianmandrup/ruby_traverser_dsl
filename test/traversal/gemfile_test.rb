require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test select block with multi element array argument" do                           
    src = %q{    
      gem 'ripper', :src => 'github' 
    }
    code = Ripper::RubyBuilder.build(src)               
    call_node = code.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
  end 
  
  define_method :"test find gem statement inside group" do                           
    src = %q{    
      group :test do
        gem 'ripper', :src => 'github' 
      end
    }
    code = Ripper::RubyBuilder.build(src)               
    block_node = code.find_call('group', :args => [:test], :block => true) 
    assert_equal Ruby::Call, block_node.class
    call_node = block_node.find_call('gem', :args => ['ripper', {:src => 'github'}]) 
    assert_equal Ruby::Call, call_node.class
    # puts call_node.to_ruby
  end     
            
  define_method :"test find gem statement inside group using better DSL" do                           
    src = %q{    
      gem 'ripper', :src => 'github', :blip => 'blap'       
      group :test do
        gem 'ripper', :src => 'github' 
      end
  
    }
    code = Ripper::RubyBuilder.build(src)              
    code.inside_block('group', :args => [:test]) do |b|
      call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}])
      assert_equal Ruby::Call, call_node.class
      puts call_node.to_ruby
    end
  end   
       

    define_method :"test find variabel in method definition" do                           
      src = %q{    
        def hello_world(a)
          my_var
        end  
      }    
            
      code = Ripper::RubyBuilder.build(src)               
      code.inside_def('hello_world', :params => ['a']) do |b|
        var_node = b.find_variable('my_var')
        assert_equal Ruby::Variable, var_node.class
        puts var_node.to_ruby
      end
    end  

    define_method :"test find assignment in method definition" do                           
      src = %q{    
        def hello_world(a)
          my_var = 2
        end  
      }    
            
      code = Ripper::RubyBuilder.build(src)               
      code.inside_def('hello_world', :params => ['a']) do |b|
        ass_node = b.find_assignment('my_var')
        assert_equal Ruby::Assignment, ass_node.class
        puts ass_node.to_ruby
      end
    end  

  
  define_method :"test find method definition" do                           
    src = %q{    
      def hello_world(a)
        gem 'ripper', :src => 'github' 
      end  
    }
    code = Ripper::RubyBuilder.build(src)               
    code.inside_def('hello_world', :params => ['a']) do |b|
      call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}], :verbose => true)
      assert_equal Ruby::Call, call_node.class
      puts call_node.to_ruby
    end
  end  

  
end