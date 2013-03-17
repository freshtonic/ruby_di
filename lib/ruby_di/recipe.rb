
module RubyDI
  class Recipe 

    attr_accessor :dependency_names

    def initialize(name, dependency_names = nil, &steps)
      @name = name
      @dependency_names = dependency_names || infer_dependency_names(steps)
      @steps = steps 
    end

    def make(*dependencies)
      actual, required = dependencies.count, @dependency_names.count
      if actual != required
        raise InternalError,
          "incorrect number of dependencies: #{actual} provided, #{required} required"
      end
      @steps.call *Array(dependencies)
    end

  private
    def infer_dependency_names(proc)
      proc.parameters
          .select { |type, _| [:req, :opt].include? type }
          .map { |_, name| name.to_s }
    end
  end
end
