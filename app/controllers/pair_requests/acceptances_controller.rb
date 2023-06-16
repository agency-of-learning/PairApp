class PairRequests::AcceptancesController < ApplicationController
  def create
    debugger
    @pair_request = PairRequest.find(params[:pair_request_id])
    authorize @pair_request, policy_class: PairRequest::AcceptancePolicy
    @pair_request.accepted!

    flash[:notice] = 'You have accepted this pair request.'
    redirect_to pair_request_path(@pair_request)
  end
end

