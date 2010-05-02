require File.dirname(__FILE__) + '/../test_helper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test select Class with complex namespace" do                           
    src = %q{      
      class Abc::Bef::Monty 
      end 
    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find(:class, 'Abc::Bef::Monty') 
    assert_equal Ruby::Class, clazz_node.class
    # puts "class: #{clazz_node}" 
  end


  define_method :"test select Class that inherits from other Class" do                           
    src = %q{      
      class Monty < Abc::Blip 
      end 
    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find(:class, 'Monty').where(:superclass => 'Abc::Blip') 
    assert_equal Ruby::Class, clazz_node.class     
  end
  
  define_method :"test select Class that inherits from other Class and is contained within specific parent module" do                           
    src = %q{      
      module Hello
        include Marsha
        
        class Monty < Abc::Blip 
        end 
      end
    }
    code = Ripper::RubyBuilder.build(src)              
    clazz_node = code.find(:class, 'Monty').where |mod|
      where(:superclass => 'Abc::Blip') && where(:parent, :module => 'Hello').where(:include, 'Marsha')
    end
    assert_equal Ruby::Class, clazz_node.class     
  end
  
end