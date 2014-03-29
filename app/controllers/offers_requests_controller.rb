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

  private

  def offers_request_params
    params.require(:offers_request).permit :uid, :pub0, :page
  end
end
