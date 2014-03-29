require 'spec_helper'

describe HomeController do
  describe '#index' do
    subject { get :index }

    it { should be_success }
  end
end
