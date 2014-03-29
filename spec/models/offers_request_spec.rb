require 'spec_helper'

describe OffersRequest do
  let!(:sample) { described_class.new }

  subject { sample }

  it { should be_tableless }

  it 'has appropriate attributes' do
    expect(subject.attributes.keys.sort).to eq %w(id uid pub0 page).sort
  end
end
