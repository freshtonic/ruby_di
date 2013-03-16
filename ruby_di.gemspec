$:.push File.expand_path("../lib", __FILE__)
require "ruby_di/version"

Gem::Specification.new do |s|
  s.name        = "ruby_di"
  s.version     = RubyDI::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Sadler"]
  s.email       = [ "James Sadler <freshtonic@gmail.com>"]
  s.homepage    = "https://github.com/freshtonic/ruby_di.git"
  s.summary     = %q{An dependency injection micro-library for Ruby}
  s.description = %q{An dependency injection micro-library for Ruby}
  s.license     = "MIT"

  # s.add_runtime_dependency 'savon', '2.1.0'

  s.add_development_dependency 'rspec', '>= 2.0.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
