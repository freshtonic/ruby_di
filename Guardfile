group :rspec do
  guard :rspec, :version => 2,
    :cli => "--color -r rspec/instafail -f RSpec::Instafail" do

    watch( 'lib/ruby_di.rb' ) { 'spec' }
    watch( %r{^lib/ruby_di/.+\.rb} ) { 'spec' }
    watch( 'spec/spec_helper.rb' ) { 'spec' }
    watch( %r{^spec/ruby_di/.+_spec\.rb} ) { 'spec' }
  end
end
