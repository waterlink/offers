require 'spec_helper'

class Tableless::ExampleClass < ActiveRecord::Base
  tableless

  column :name, :string
  column :id, :integer
  column :content, :text

  validates_presence_of :name, :id
end

describe Tableless do
  subject { sample }

  context 'valid sample' do
    let!(:sample) { Tableless::ExampleClass.new name: 'test', id: 35 }

    it { should be_valid }
  end

  context 'invalid sample' do
    let!(:sample) { Tableless::ExampleClass.new name: 'test', content: 'hello world' }

    it { should_not be_valid }
  end
end
