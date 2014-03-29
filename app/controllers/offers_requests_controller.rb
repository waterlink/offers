class OffersRequestsController < ApplicationController
  def index
    @offers_request = OffersRequest.new
  end
end
