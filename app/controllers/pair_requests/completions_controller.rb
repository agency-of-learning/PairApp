class PairRequests::CompletionsController < ApplicationController
  def create
    @pair_request = PairRequest.find(params[:pair_request_id])
    authorize @pair_request, policy_class: PairRequest::CompletionPolicy
    @pair_request.completed!

    flash[:notice] = 'You have completed this pair request.'
    redirect_to pair_request_path(@pair_request)
  end
end
