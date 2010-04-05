# Ruby traverser ##

A DSL for traversing ruby code as an object model (graph), which lets you find parts of the ruby code of interest.
The traverser leverages `ripper2ruby`, which leverages `ripper`, which comes with ruby 1.9. Ruby 1.9 is thus required.

See the unit tests in the test directory for examples of use.

## Finders ##

* find_module(name)
* find_class(name, options = {})
* find_call(name, options = {})
* find_block(name, options = {})
* find_def(name, options = {})


## Find module ##

<pre>
  src = %q{      
    module Xyz::Xxx::Blip
      2
    end    
  }
  
  code = Ripper::RubyBuilder.build(src)          
  module_node = code.find_module('Xyz::Xxx::Blip') 
  assert_equal Ruby::Module, module_node.class 
</pre>

## Find class ##

<pre>
# class Monty::Python ... end
clazz_node = code.find_class('Monty::Python')   
</pre>

Find class inheriting from a certain superclass
<pre>
# class Monty < Abc::Blip ... end
clazz_node = code.find_class('Monty', :superclass => 'Abc::Blip')   
</pre>

## Find call ##
                                                               
<pre>
# gem 'ripper', :src => 'github' 
gem_call = code.find_call('gem', :args => ['ripper', {:src => 'github'}])   
</pre>


## Find block ##        

<pre>
# my_block do ... end
block_node = code.find_block('my_block')   
</pre>

<pre>
# my_block do |v| ... end
block_node = code.find_block('my_block', :block_params => ['v'])   
</pre>

<pre>
# my_block 7, 'a' do ... end
block_node = code.find_block('my_block', :args => [7, 'a'])   
</pre>
                                                 
<pre>
# my_block 7, 'a', :k => 32 do |v| ... end
block_node = code.find_block('my_block', :args => [7, 'a', {:k => 32}], :block_params => ['v'])   
</pre>

<pre>
# my_block :a => 7, b => 3 do |v| ... end
block_node = code.find_block('my_block', :args => [{:a => 7, 'b' => 3}])   
</pre>     

<pre>                                                                      
# my_block ['a', 'b'] do |v| ... end  
block_node = code.find_block('my_block', :args => [{:array =>['a', 'b']}])   
</pre>

## Inside ##

The following finder methods have corresponding `inside_` functions, which support block DSL constructs as shown below.

* inside_module
* inside_class
* inside_def
* inside_block

<pre>
  # source code
  src = %q{      
    gem 'ripper', :src => 'github', :blip => 'blap'       
    group :test do
      gem 'ripper', :src => 'github' 
    end  
  }
</pre>

<pre>
  code = Ripper::RubyBuilder.build(src)              
  # chaining finders using 'inside__' DSL block constructs  
  code.inside_block('group', :args => [:test]) do |b|
    call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}])
    assert_equal Ruby::Call, call_node.class
    puts call_node.to_ruby # output ruby code as string for found node 
  end    
</pre>

<pre>  
  src = %q{    
    def hello_world(b)
      3
    end

    def hello_world(a)
      gem 'ripper', :src => 'github' 
    end

  }  
</pre>    

<pre>     
  # chaining finders using 'inside__' DSL block constructs
  code = Ripper::RubyBuilder.build(src)            
  code.inside_def('hello_world', :params => ['a']) do |b|
    call_node = b.find_call('gem', :args => ['ripper', {:src => 'github'}])
    assert_equal Ruby::Call, call_node.class
    puts call_node.to_ruby # output ruby code as string for found node 
  end  
</pre>

More to come soon... 

## TODO ##

Convert into a jeweler gem with dependency on `ripper2ruby`

## Note on Patches/Pull Requests ##
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright ##

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.