require 'spec_helper'

describe 'offers_requests/index.html.slim' do
  subject { render }

  context 'no offers' do
    let!(:offers) { [] }

    before { assign :offers, offers }

    it { should have_css '.no_offers' }
  end
end
