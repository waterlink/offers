require 'spec_helper'

describe OffersRequest do
  let!(:sample) { described_class.new }

  subject { sample }

  it { should be_tableless }

  it 'has appropriate attributes' do
    expect(subject.attributes.keys.sort).to eq %w(id uid pub0 page).sort
  end

  describe 'default attributes' do
    it 'has appropriate attributes' do
      expect(subject.attributes.symbolize_keys)
        .to eq id: nil, uid: 'john', pub0: '', page: 1
    end
  end

  describe 'validations' do
    context 'empty uid' do
      let!(:sample) { build :offers_request, uid: '' }

      it { should_not be_valid }
    end

    context 'empty page' do
      let!(:sample) { build :offers_request, page: nil }

      it { should_not be_valid }
    end

    context 'non numeric page' do
      let!(:sample) { build :offers_request, page: 'test' }

      it { should_not be_valid }
    end
  end
end
