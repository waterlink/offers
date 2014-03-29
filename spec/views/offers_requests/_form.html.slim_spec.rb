require 'spec_helper'

describe 'offers_requests/_form.html.slim' do
  let!(:offers_request) { build :offers_request }

  subject { render 'offers_requests/form.html.slim', offers_request: offers_request }

  it { should have_css 'form' }
end
