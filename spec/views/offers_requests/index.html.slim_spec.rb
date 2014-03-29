require 'spec_helper'

describe 'offers_requests/index.html.slim' do
  let!(:offers_request) { build :offers_request }

  before { assign(:offers_request, offers_request) }

  subject { render }

  it { should render_template 'offers_requests/index' }

  it { should render_template partial: 'offers_requests/_form',
                              locals: { offers_request: offers_request } }
end
