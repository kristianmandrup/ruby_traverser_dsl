module RubyAPI
  module Inside
    def inside_block(name, options = {}, &block) 
      s = find_block(name, options) 
      block.arity < 1 ? s.instance_eval(&block) : block.call(s)
    end 

    def inside_module(name, &block)
      s = find_module(name)
      block.arity < 1 ? s.instance_eval(&block) : block.call(s)
    end

    def inside_class(name, options = {}, &block)
      s = find_class(name, options)
      block.arity < 1 ? s.instance_eval(&block) : block.call(s)
    end

    def inside_def(name, options = {}, &block)
      s = find_def(name, options)  
      block.arity < 1 ? s.instance_eval(&block) : block.call(s)
    end
  end
end
