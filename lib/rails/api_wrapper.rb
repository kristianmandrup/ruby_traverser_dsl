module RubyAPI
  module Rails
    module Gemfile
      def inside_group(name, &block)
        inside_block('group', :args => [:"#{name}"], :extend => RubyAPI::Rails::Gemfile, &block)
      end

      def add_gem(name) 
        append_code("gem '#{name}'")
      end

      def find_gem(name, options = {})
        find_call('gem', :args => ["#{name}", options])
      end
    end
  end
end