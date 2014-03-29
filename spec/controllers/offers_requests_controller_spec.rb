require 'spec_helper'

describe OffersRequestsController do
  describe '#new' do
    subject { get :new }

    it { should be_success }

    describe 'assigns' do
      before { get :new }

      subject { assigns(example.metadata[:name]) }

      context name: :offers_request do
        it { should be_a OffersRequest }
      end
    end
  end
end
