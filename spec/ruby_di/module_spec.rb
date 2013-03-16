
require 'spec_helper'

describe RubyDI::Module do

  let(:module_with_no_dependencies) { RubyDI::Module.new 'no-deps' }
  let(:aModule) { module_with_no_dependencies }

  describe 'with no recipe dependencies' do
    before do
      aModule.recipe('CartoonCharacter', []) { 'I am Weasel' }
    end

    subject { aModule.get('CartoonCharacter') }

    it { should eq 'I am Weasel' }
  end

  describe 'with recipe dependencies' do
    before do
      aModule.recipe('Parent', []) { 'Mr. Smith' }
      aModule.recipe('Child', ['Parent']) { |parent| "I am a child of #{parent}" }
    end

    subject { aModule.get('Child') }

    it { should eq 'I am a child of Mr. Smith' }
  end

  describe 'with inferred recipe dependencies' do
    before do
      aModule.recipe('a') { 'dep a' }
      aModule.recipe('b') { |a| "dep b, #{a}" }
    end

    subject { aModule.get('b') }

    it { should eq 'dep b, dep a' }
  end
  
  describe 'module dependencies' do
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
