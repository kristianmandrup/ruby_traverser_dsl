define_method :"test find assignment in method definition and replace value of right side" do                           
  src = %q{    
    def hello_world(a)
      my_var = 2
    end  
  }    

  code = Ripper::RubyBuilder.build(src)               

  code.find(:def, 'hello_world', :params => ['a']) do |b|
    ass_node = b.find(:assignment, 'my_var')
    assert_equal Ruby::Assignment, ass_node.class

    ass_node.update(:value => "3")      
    puts b.to_ruby
  end
end  

