require 'api'

class Api::Offers
  include HTTParty
  format :json

  def self.query(params)
    offers = get_offers get Rails.configuration.api['endpoint'], query: params_with_auth(params)
    deserialize offers
  end

  def self.signature(params, api_key)
    data = params.keys.sort.map { |key| "#{key}=#{params[key]}" }.join '&'
    data << "&#{api_key}"
    digest_algorightm data
  end

  def self.digest_algorightm(data)
    Digest::SHA1.hexdigest data
  end

  private

  def self.params_with_auth(params)
    params = params.slice(:uid, :pub0, :page).merge Rails.configuration.api['params']
    params[:hash_key] = signature params, Rails.configuration.api['api_key']
    params
  end

  def self.get_offers(response)
    check_signature response.body,
                    response.headers[Rails.configuration.api['signature_header']],
                    Rails.configuration.api['api_key']
    if response['message'] == 'NO_CONTENT'
      []
    else
      response['offers']
    end
  end

  def self.check_signature(body, signature, api_key)
    unless digest_algorightm("#{body}#{api_key}") == signature
      raise Exception.new 'Offers server API responded with bad signature'
    end
  end

  def self.deserialize(offers)
    offers.map do |offer|
      offer = offer.slice 'title', 'link', 'thumbnail', 'payload'
      offer['thumbnail'] = offer['thumbnail']['lowres']
      Offer.new offer
    end
  end
end
