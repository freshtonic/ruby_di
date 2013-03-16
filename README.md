# Super-lightweight DI for Ruby, inspired by Angular.js

## Example

```ruby
moduleA = RubyDI::Module.new 'moduleA'
moduleA.recipe 'announcer' do 
  class Announcer 
    def say
      "hello from Announcer!"
    end
  end
  Announcer.new
end

moduleB = RubyDI::Module.new 'moduleB'
moduleB.recipe 'myService', %w(announcer) do |announcer|
  class MyService
    def initialize(announcer)
      @announcer = announcer
    end

    def do_it!
      @announcer.say
    end
  end
  MyService.new(announcer) 
end

# Creates a new module that combines the recipes
app = moduleA << moduleB

app.get('myService').new.do_it! # => "hello from Announcer!"
```

## Why?

Angular.js's DI system is pretty neat.  This project is the humble beginning of
something like it for Ruby.  There's lots to do: there's currently no error
checking or real-world example,  and it's just something I made in an afternoon
for fun, but it has the potential to be useful one day.

