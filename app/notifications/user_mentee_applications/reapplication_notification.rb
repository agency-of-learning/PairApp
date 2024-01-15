# To deliver this notification:
#
# UserMenteeApplications::ReapplicationNotification
#   .with(post: @post).deliver_later(current_user)
# UserMenteeApplications::ReapplicationNotification
#   .with(post: @post).deliver(current_user)

module UserMenteeApplications
  class ReapplicationNotification < Noticed::Base
    deliver_by :email,
      mailer: 'MenteeApplicationMailer',
      method: :notify_applicant_to_reapply,
      enqueue: true

    param :active_cohort_name
  end
end
