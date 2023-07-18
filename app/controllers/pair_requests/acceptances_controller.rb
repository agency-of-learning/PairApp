class PairRequests::AcceptancesController < ApplicationController
  def create
    @pair_request = PairRequest.find(params[:pair_request_id])
    authorize @pair_request, policy_class: PairRequest::AcceptancePolicy
    @pair_request.accepted!
    PairRequest::AcceptanceNotification.with(pair_request: @pair_request).deliver(@pair_request.author)

    flash[:notice] = 'You have accepted this pair request.'
    redirect_to pair_request_path(@pair_request)
  end
end
