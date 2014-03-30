require 'spec_helper'

describe 'offers_requests/index.html.slim' do
  before { assign :offers, offers }

  subject { render }

  context 'no offers' do
    let!(:offers) { [] }

    it { should have_css '.no_offers' }
  end

  context 'has offers' do
    let!(:offer_1) { build :offer }
    let!(:offer_2) { build :offer }
    let!(:offers) { [offer_1, offer_2] }

    it { should render_template 'offers/_offer' }
  end
end
