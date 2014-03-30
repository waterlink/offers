require 'spec_helper'
require 'api/offers'

describe Api::Offers do
  describe 'class' do
    subject { described_class }

    describe '#signature' do
      let!(:params) { { hello: 'world', test: 'query', id: 35 } }
      let!(:api_key) { 'some_secret_api_key' }

      it { should respond_to :signature }

      it 'returns valid signature' do
        expect(subject.signature params, api_key)
          .to eq Digest::SHA1.hexdigest("hello=world&id=35&test=query&some_secret_api_key")
      end
    end

    describe '#query' do
      it { should respond_to :query }

      context 'good params' do
        let!(:offers_request) { build :offers_request }
        before do
          stub_request(:get, /api\.[^\/]*\//)
            .to_return status: 200,
                       headers: good_headers,
                       body: good_api_response
        end

        it 'returns some offers' do
          expect(subject.query offers_request).to_not be_blank
        end

        it 'returns list of Offers instances' do
          subject.query(offers_request).each do |offer|
            expect(offer).to be_a Offer
          end
        end
      end

      context 'bad params' do
        let!(:offers_request) { build :offers_request, page: 5000 }
        before do
          stub_request(:get, /api\.[^\/]*\//)
            .to_return status: 200,
                       headers: no_offers_headers,
                       body: no_offers_response
        end

        it 'returns no offers' do
          expect(subject.query offers_request).to be_blank
        end
      end

      context 'bad signature' do
        let!(:offers_request) { build :offers_request, page: 5000 }
        before do
          stub_request(:get, /api\.[^\/]*\//)
            .to_return status: 200,
                       headers: bad_headers,
                       body: no_offers_response
        end

        it 'raises exception' do
          expect { subject.query offers_request }.to raise_exception
        end

      end
    end
  end


  let!(:good_api_response) do
    YAML::load("
code: OK
message: OK
offers:
- title: Super Offer
  link: https://google.com
  thumbnail:
    lowres: https://google.com/images/srpr/logo8w.png
    highres: https://google.com/images/srpr/logo11w.png
  payout: 150
- title: Ultra Offer
  link: https://google.com
  thumbnail:
    lowres: https://google.com/images/srpr/logo8w.png
    highres: https://google.com/images/srpr/logo11w.png
  payout: 1500
    ").to_json
  end

  let!(:good_headers) do
    {
      Rails.configuration.api['signature_header'] =>
        Digest::SHA1.hexdigest("#{good_api_response}#{Rails.configuration.api['api_key']}")
    }
  end

  let!(:no_offers_response) do
    YAML::load("
code: NO_CONTENT
message: NO_CONTENT
    ").to_json
  end

  let!(:no_offers_headers) do
    {
      Rails.configuration.api['signature_header'] =>
        Digest::SHA1.hexdigest("#{no_offers_response}#{Rails.configuration.api['api_key']}")
    }
  end

  let!(:bad_headers) do
    {
      Rails.configuration.api['signature_header'] =>
       'I am obviously a bad signature!'
    }
  end
end
