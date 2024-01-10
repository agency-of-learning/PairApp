class PairRequests::AcceptancesController < ApplicationController
  def create
    @pair_request = PairRequest.find(params[:pair_request_id])
    authorize @pair_request, policy_class: PairRequests::AcceptancePolicy
    @pair_request.accepted!
    send_notifications

    flash[:notice] = 'You have accepted this pair request.'
    redirect_to pair_request_path(@pair_request)
  end

  private

  def send_notifications
    PairRequest::AcceptanceNotification.with(pair_request: @pair_request).deliver(@pair_request.author)
    PairRequest::CompletionReminderNotification.with(pair_request: @pair_request).deliver(@pair_request.author)
  end
end
