
module RubyDI
  class Recipe 

    attr_accessor :dependency_names

    def initialize(name, dependency_names, &steps)
      @name = name
      @dependency_names = dependency_names
      @steps = steps 
    end

    def make(dependencies)
      @steps.call *dependencies
    end
  end
end
