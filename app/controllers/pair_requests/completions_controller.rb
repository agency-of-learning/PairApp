class PairRequests::CompletionsController < ApplicationController
  def create
    @pair_request = PairRequest.find(params[:pair_request_id])
    authorize @pair_request, policy_class: PairRequests::CompletionPolicy
    @pair_request.completed!
    @pair_request.create_draft_feedback!
    PairRequests::CompletionNotification.with(pair_request: @pair_request).deliver(@pair_request.invitee)

    flash[:notice] = 'You have completed this pair request.'
    redirect_to edit_feedback_path(@pair_request.author_feedback)
  end
end
