require 'spec_helper'
require 'api/offers'

describe OffersRequestsController do
  describe '#new' do
    before { get :new }

    subject { response }

    it { should be_success }

    describe 'assigns' do
      subject { assigns(example.metadata[:name]) }

      context name: :offers_request do
        it { should be_a OffersRequest }
      end
    end
  end

  describe '#create' do
    let!(:data) { { offers_request: attributes_for(:offers_request) } }

    before { Api::Offers.stub(query: ['some', 'offers']) }
    before { post :create, data }

    subject { response }

    it { should be_success }

    it { should render_template 'offers_requests/index' }

    describe 'assigns' do
      subject { assigns(example.metadata[:name]) }

      context name: :offers do
        it { should respond_to :count }
      end
    end

    describe 'form validation' do
      context 'invalid' do
        let!(:data) { { offers_request: attributes_for(:invalid_offers_request) } }

        it { should render_template 'offers_requests/new' }

        describe 'assigns' do
          subject { assigns(example.metadata[:name]) }

          context name: :offers do
            it { should be nil }
          end

          context name: :offers_request do
            it { should_not be nil }
            it { should_not be_valid }

            it 'has errors' do
              expect(subject.errors).to be_any
            end
          end
        end
      end
    end
  end
end
