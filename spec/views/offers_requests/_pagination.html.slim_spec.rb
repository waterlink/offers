require 'spec_helper'

describe 'offers_requests/_pagination.html.slim' do
  let!(:offers_request) { build :offers_request, page: 2 }

  before { assign :offers_request, offers_request }

  subject { render 'offers_requests/pagination', options }

  context 'has prev and next' do
    let!(:options) { { has_prev: true, has_next: true } }

    it { should render_template 'offers_requests/pagination/_prev' }
    it { should render_template 'offers_requests/pagination/_next' }

    it { should have_css 'form input[type="hidden"]#offers_request_page[value="1"]' }
    it { should have_css 'form input[type="hidden"]#offers_request_page[value="3"]' }

    it { should have_css 'form input[type="submit"].prev' }
    it { should have_css 'form input[type="submit"].next' }
  end

  context 'has not prev and has next' do
    let!(:options) { { has_prev: false, has_next: true } }

    it { should_not render_template 'offers_requests/pagination/_prev' }
    it { should render_template 'offers_requests/pagination/_next' }
  end

  context 'has prev and has not next' do
    let!(:options) { { has_prev: true, has_next: false } }

    it { should render_template 'offers_requests/pagination/_prev' }
    it { should_not render_template 'offers_requests/pagination/_next' }
  end

  context 'has not prev and next' do
    let!(:options) { { has_prev: false, has_next: false } }

    it { should_not render_template 'offers_requests/pagination/_prev' }
    it { should_not render_template 'offers_requests/pagination/_next' }
  end
end
