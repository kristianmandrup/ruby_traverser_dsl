# require 'rubygems'
# require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ruby_traverser"
    gem.summary = %Q{traverse ruby code using a nice DSL}
    gem.description = %Q{traverse an object model representation of ruby code using a nice DSL}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/ruby_trav"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency "rspec", ">= 2.0.0"
    gem.add_dependency "ripper2ruby", "> 0.0.1"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    
    # add more gem options here    
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# require 'rspec/rake_task'
# Rspec::Core::RakeTask.new(:spec) do |spec|
# #  spec.libs << 'lib' << 'spec'
# #  spec.spec_files = FileList['spec/**/*_spec.rb']
# end
# 
# require 'rspec/rake_task'
# Rspec::Core::RakeTask.new(:rcov) do |spec|
# #  spec.libs << 'lib' << 'spec'
# #  spec.pattern = 'spec/**/*_spec.rb'
# #  spec.rcov = true
# end  
# 
# task :spec => :check_dependencies
# 
# task :default => :spec
# 
# require 'rake/rdoctask'
# Rake::RDocTask.new do |rdoc|
#   version = File.exist?('VERSION') ? File.read('VERSION') : ""
# 
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "ruby_trav #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end
