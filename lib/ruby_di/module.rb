
module RubyDI
  class Module

    def initialize(name)
      @name         = name
      @recipes      = {}
      @built        = {}
    end

    def recipe(name, dependency_names = nil, &block)
      @recipes[name] = Recipe.new name, dependency_names, &block
    end

    def get(name)
      dependencies = *resolve(@recipes[name].dependency_names)
      @recipes[name].make dependencies
    end

    def << (other)
      mod = Module.new 'generated'
      mod.instance_variable_set(
        :@recipes, @recipes.merge(
          other.instance_variable_get(:@recipes)))
      mod 
    end

    private

    def resolve(dependency_names)
      dependency_names.map do |dn|
        @built[dn] ||= get(dn)
      end
    end

  end

end
