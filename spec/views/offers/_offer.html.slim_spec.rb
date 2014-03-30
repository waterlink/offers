require 'spec_helper'

describe 'offers/_offer.html.slim' do
  let!(:offer) { build :offer }

  subject { render 'offers/offer', offer: offer }

  it { should have_css '.offer' }

  it { should have_css '.offer .title', text: offer.title }
  it { should have_css '.offer .payout', text: offer.payout }
  it { should have_css ".offer .thumbnail img[src=\"#{offer.thumbnail}\"]" }

  it { should have_css "a[href=\"#{offer.link}\"]" }
end
