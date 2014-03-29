require 'spec_helper'

describe Offer do
  let!(:sample) { described_class.new }

  subject { sample }

  it { should be_tableless }

  it 'has appropriate attributes' do
    expect(subject.attributes.keys.sort)
      .to eq %w(id title payout thumbnail link).sort
  end
end
