require 'api/offers'

class OffersRequestsController < ApplicationController
  def new
    @offers_request = OffersRequest.new
  end

  def create
    @offers_request = OffersRequest.new offers_request_params
    if @offers_request.valid?
      @offers = Api::Offers.query @offers_request
      render :index
    else
      render :new
    end
  end

  # NOTE: It exists only for testing purposes
  #       especially when there are no offers
  #       available
  def test
    @offers_request = build_test_request
    if Rails.env.development?
      @offers = build_test_offers
      render :index
    else
      render status: :forbidden, text: '403 Forbidden'
    end
  end

  private

  def offers_request_params
    params.require(:offers_request).permit :uid, :pub0, :page
  end

  def build_test_offers
    require 'factory_girl'
    [ FactoryGirl.build(:offer), FactoryGirl.build(:offer) ]
  end

  def build_test_request
    require 'factory_girl'
    FactoryGirl.build :offers_request
  end
end
