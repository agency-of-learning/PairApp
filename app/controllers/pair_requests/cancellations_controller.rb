class PairRequests::CancellationsController < ApplicationController
  def create
    @pair_request = PairRequest.find(params[:pair_request_id])
    authorize @pair_request, policy_class: PairRequest::CancellationPolicy
    @pair_request.cancelled!

    flash[:notice] = 'You have cancelled this pair request.'
    redirect_back_or_to pair_requests_path
  end
end
