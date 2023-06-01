module FeedbacksHelper
  def pending_feedback_link(pair_request, current_user)
    feedback = pair_request.references.find_by(author: current_user, status: 'draft')
    link_to 'Submit Feedback', edit_feedback_path(feedback.id), class:"btn bg-red-500" if feedback.present?
  end
end
