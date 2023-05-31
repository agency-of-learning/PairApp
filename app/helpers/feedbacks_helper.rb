module FeedbacksHelper
  module FeedbackHelper
    def feedback_link_for_current_user(current_user)
      feedback = Feedback.find_by(author: current_user, status: 'draft')
      if feedback
        link_to 'Edit Feedback', edit_feedback_path(feedback)
      end
    end
  end
  
end
