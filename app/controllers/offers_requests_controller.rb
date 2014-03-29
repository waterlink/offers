class OffersRequestsController < ApplicationController
  def new
    @offers_request = OffersRequest.new
  end
end
