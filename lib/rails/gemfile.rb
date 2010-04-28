module RubyCodeAPI
  module Rails
    module Gemfile
      def inside_group(name, &block)
        inside_block('group', :args => [:"#{name}"], :extend => RubyAPI::Rails::Gemfile, &block)
      end

      def add_gem(name) 
        append_code("gem '#{name}'")
      end

      def replace_gem(name, replace_name)
        found = find_gem(name)
        puts "gem:#{found}"
        found.replace(:arg => name, :replace_arg => replace_name) if found       
      end

      def find_gem(name, options = nil)
        find_call('gem', :args => ["#{name}", options])
      end
    end
  end
end