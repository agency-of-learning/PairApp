# To deliver this notification:
#
# UserMenteeApplications::RejectionNotification
#   .with(post: @post).deliver_later(current_user)
# UserMenteeApplications::RejectionNotification
#   .with(post: @post).deliver(current_user)

module UserMenteeApplications
  class RejectionNotification < Noticed::Base
    deliver_by :email,
      mailer: 'MenteeApplicationMailer',
      method: :notify_applicant_of_rejection,
      enqueue: true
  end
end
