
require 'spec_helper'

describe RubyDI::Module do

  let(:theModule) {  RubyDI::Module.new 'test-module'  }

  describe 'with no recipe dependencies' do
    before do
      theModule.recipe('CartoonCharacter', []) { 'I am Weasel' }
    end

    subject { theModule.get('CartoonCharacter') }

    it { should eq 'I am Weasel' }
  end

  describe 'with recipe dependencies' do
    before do
      theModule.recipe('Parent', []) { 'Mr. Smith' }
      theModule.recipe('Child', ['Parent']) { |parent| "I am a child of #{parent}" }
    end

    subject { theModule.get('Child') }

    it { should eq 'I am a child of Mr. Smith' }
  end

  describe 'inter-module dependencies' do
    let(:moduleA) { RubyDI::Module.new 'moduleA' }
    let(:moduleB) { RubyDI::Module.new 'moduleB' }
    let(:app) { moduleA << moduleB }

    before do
      moduleA.recipe('Parent', []) { 'Mr. Smith' }
      moduleB.recipe('Child', ['Parent']) { |parent| "I am a child of #{parent}" }
    end

    subject { app.get('Child') }

    it { should eq 'I am a child of Mr. Smith' }
  end

  context "module combination" do
    let(:moduleA) { RubyDI::Module.new 'moduleA' }
    let(:moduleB) { RubyDI::Module.new 'moduleB' }
    let(:moduleC) { RubyDI::Module.new 'moduleC' }

    before do
      moduleA.recipe('Foo') { 'moduleA' }
      moduleB.recipe('Bar', ['Foo']) { |foo| "my foo came from #{foo}" }
      moduleC.recipe('Foo') { "moduleC" }
    end

    describe "is not commutative, order matters" do
      let(:app) { moduleA << moduleB << moduleC }
      subject { app.get 'Bar' }
      it { should eq "my foo came from moduleC" }
    end

    describe "is not commutative, order matters (different order)" do
      let(:app) { moduleC << moduleA << moduleB }
      subject { app.get 'Bar' }
      it { should eq "my foo came from moduleA" }
    end
  end

  describe 'building classes' do
    let(:app) { RubyDI::Module.new 'app' }

    before do
      app.recipe('ClassA', []) do
        class ClassA
          def say
            'Hello from ClassA'
          end
        end
        ClassA
      end

      app.recipe('ClassB', ['ClassA']) do |klassA|
        class ClassB < klassA 
          def say
            'Hello from ClassB'
          end
        end
        ClassB
      end
    end

    subject { app.get('ClassB').new.say }

    it { should eq 'Hello from ClassB' }
  end
end
