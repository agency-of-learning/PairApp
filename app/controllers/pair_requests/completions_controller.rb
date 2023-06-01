class PairRequests::CompletionsController < ApplicationController
  def create
    @pair_request = PairRequest.find(params[:pair_request_id])
    authorize @pair_request, policy_class: PairRequest::CompletionPolicy
    @pair_request.completed!
    @pair_request.create_draft_feedback!
    flash[:notice] = 'You have completed this pair request.'

    redirect_to edit_feedback_path(@pair_request.author_feedback)
  end
end
