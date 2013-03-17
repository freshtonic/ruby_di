
$: << File.dirname(__FILE__)

require 'ruby_di/version'
require 'ruby_di/recipe'
require 'ruby_di/module'

module RubyDI 
  # This is thrown only because of a bug in RubyDI, for example when an internal
  # invariant or pre/post condition fails.
  class InternalError < StandardError; end
end
