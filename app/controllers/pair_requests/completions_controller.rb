class PairRequests::CompletionsController < ApplicationController
  def create
    @pair_request = PairRequest.find(params[:pair_request_id])
    authorize @pair_request, policy_class: PairRequest::CompletionPolicy
    @pair_request.completed!
    
    @feedback = Feedback.create_feedback_records(@pair_request)
    flash[:notice] = 'You have completed this pair request.'
    
    redirect_to edit_feedback_path(@feedback)
  end
end
