require 'spec_helper'

describe '/' do
  subject { { get: '/' } }

  it { should route_to controller: 'home', action: 'index' }
end
