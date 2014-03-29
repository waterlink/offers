require 'spec_helper'

describe OffersRequestsController do
  describe '#index' do
    subject { get :index }

    it { should be_success }

    describe 'assigns' do
      before { get :index }

      subject { assigns(example.metadata[:name]) }

      context name: :offers_request do
        it { should be_a OffersRequest }
      end
    end
  end
end
