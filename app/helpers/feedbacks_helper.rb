module FeedbacksHelper
  def pending_feedback_link(pair_request, current_user)
    feedback = pair_request.references.find_by(author: current_user, status: 'draft')
    return if feedback.blank? || feedback.locked?

    link_to 'Submit Feedback', edit_feedback_path(feedback.id), class: 'btn bg-red-500'
  end
end
