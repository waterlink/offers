require 'spec_helper'

describe 'offers_requests/index.html.slim' do
  let!(:offers_request) { build :offers_request }

  before { assign :offers, offers }
  before { assign :offers_request, offers_request }

  subject { render }

  context 'no offers' do
    let!(:offers) { [] }

    it { should have_css '.no_offers' }

    context 'on first page' do
      let!(:offers_request) { build :offers_request, page: 1 }

      it { should render_template partial: 'offers_requests/_pagination',
                                  locals: { has_prev: false, has_next: false, pagination: nil } }
    end

    context 'on other page' do
      let!(:offers_request) { build :offers_request, page: 2 }

      it { should render_template partial: 'offers_requests/_pagination',
                                  locals: { has_prev: true, has_next: false, pagination: nil } }
    end
  end

  context 'has offers' do
    let!(:offer_1) { build :offer }
    let!(:offer_2) { build :offer }
    let!(:offers) { [offer_1, offer_2] }

    it { should render_template 'offers/_offer' }

    context 'on first page' do
      let!(:offers_request) { build :offers_request, page: 1 }

      it { should render_template partial: 'offers_requests/_pagination',
                                  locals: { has_prev: false, has_next: true, pagination: nil } }
    end

    context 'on other page' do
      let!(:offers_request) { build :offers_request, page: 2 }

      it { should render_template partial: 'offers_requests/_pagination',
                                  locals: { has_prev: true, has_next: true, pagination: nil } }
    end
  end
end
