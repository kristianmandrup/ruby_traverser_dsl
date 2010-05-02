require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test select Module which include other module" do                           
    src = %q{      
      module Monty
        include Hello
      end 
    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find(:module, 'Monty').where(:include => 'Hello') 
    assert_equal Ruby::Class, clazz_node.class     
  end

  define_method :"test select Class with complex namespace" do                           
    src = %q{      
      module Abc::Bef
        module Monty 
      end 
    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find(:module, 'Abc::Bef::Monty') 
    assert_equal Ruby::Class, clazz_node.class
  end
  
  define_method :"test select module which has a class" do                           
    src = %q{ 
      module Hello
        include Bounty
      end
           
      module Hello
        include Bounty
        
        class Monty < Abc::Blip 
        end 
      end
    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find(:module, 'Monty').where |mod|
      mod.where(:class => 'Monty').and_where(:superclass => 'Abc::Blip') && mod.where(:include => 'Bounty')      
    end
    assert_equal Ruby::Class, clazz_node.class     
  end


  define_method :"test select Module where first line of content is 2" do                           
    src = %q{      
      module Xyz::Xxx::Blip
        3
        2
      end    

      module Xyz::Xxx::Blip
        2
      end    
    }
  
    code = Ripper::RubyBuilder.build(src)          
    module_node = code.find(:module, 'Xyz::Xxx::Blip').where do |mod|
      mod.first.value == 2
    end 
    assert_equal Ruby::Module, module_node.class     
  end
  
  define_method :"test select Module where first line of content is 2" do                           
    src = %q{      
      module Xyz::Xxx::Blip
        def hello
        end
      end    

      module Xyz::Xxx::Blip
        def hello(a, options = {})
        end

        def hello(x, a, options = {})
          puts "hello world"
        end
      end    
    }
  
    code = Ripper::RubyBuilder.build(src)          
    module_node = code.find(:module, 'Xyz::Xxx::Blip').where do |mod|
      mod.find(:def, 'hello').where(:params).match(:_1 => 'a', :_2 => {:code => 'options = {}'} )
    end 
    
    module_node = code.find(:module, 'Xyz::Xxx::Blip').where do |mod|
      mod.find(:def, 'hello').where(:params) |p|
        p.match(:_1 => 'a') && p.match(:_2 => {:code => 'options = {}'})
      end
    end 
        
    assert_equal Ruby::Module, module_node.class     
  end
  
end