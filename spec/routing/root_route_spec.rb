require 'spec_helper'

describe '/' do
  subject { { get: '/' } }

  it { should route_to controller: 'offers_requests', action: 'index' }
end
