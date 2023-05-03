class PairRequests::RejectionsController < ApplicationController
  def create
    # @pair_request = PairRequest.find(params[:pair_request_id])
    @pair_request = PairRequest.find(params[:pair_request_id])
    @pair_request.update_attribute(:status, :rejected)

    flash[:notice] = 'You have rejected this pair request.'

    redirect_to pair_request_path(@pair_request)
  end
end
