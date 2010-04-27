require File.dirname(__FILE__) + '/../test_helper'
require 'yaml'

require 'rails/api_wrapper'

class TraversalTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test find gem statement inside group using DSL and then insert new gem statement" do                           
    src = %q{                 
group :test do
  gem 'ripper', :src => 'github' 
  gem 'blip'
end  
    }
    
    code = Ripper::RubyBuilder.build(src)                 

    code.extend(RubyAPI::Rails::Gemfile)
    code.inside_group :test do |b|      
      b.add_gem 'cucumber' if !b.find_gem 'cucumber'          
      puts b.to_ruby
    end
  end
end

