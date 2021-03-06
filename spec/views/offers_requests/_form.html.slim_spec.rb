require 'spec_helper'

describe 'offers_requests/_form.html.slim' do
  let!(:offers_request) { build :offers_request }

  before { render 'offers_requests/form.html.slim', offers_request: offers_request }

  subject { rendered }

  it { should have_css 'form' }

  it { should have_css 'input#offers_request_uid[type=text]' }
  it { should have_css 'textarea#offers_request_pub0' }
  it { should have_css 'input#offers_request_page[type=number]' }

  it { should have_css 'input[type=submit]' }

  context 'invalid form' do
    let!(:offers_request) { build :invalid_offers_request }

    it { should have_css '.field_with_errors' }

    it { should have_css '.error', text: 'can\'t be blank' }
    it { should have_css '.error', text: 'is not a number' }
  end
end
