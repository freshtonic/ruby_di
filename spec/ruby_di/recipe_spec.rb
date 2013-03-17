
require 'spec_helper'

include RubyDI

describe Recipe do
  context "inferred dependency names" do
    subject { Recipe.new('test') {|foo,bar,baz|} }
    its(:dependency_names) { should eq %w(foo bar baz) }
  end

  context "explicit dependency names" do
    subject { Recipe.new('test', %w(foo bar baz)) {|a,b,c|} }
    its(:dependency_names) { should eq %w(foo bar baz) }
  end

  context "making an object" do
    let(:recipe) do
      Recipe.new('test') do |name,message|
        "Hi #{name}, #{message}"
      end
    end

    subject { recipe.make ['John', 'You have mail!'] }
    it { should eq "Hi John, You have mail!" }
  end

  context "not providing all of the dependencies" do
    let(:recipe) { Recipe.new('test') {|a,b|} }

    subject { lambda{ recipe.make ['John'] } }
    it { should raise_error InternalError, "1 for 2" }
  end
end
