# To deliver this notification:
#
# UserMenteeApplications::CodeChallengeApprovedNotification
#   .with(post: @post).deliver_later(current_user)
# UserMenteeApplications::CodeChallengeApprovedNotification
#   .with(post: @post).deliver(current_user)

module UserMenteeApplications
  class CodeChallengeApprovedNotification < Noticed::Base
    deliver_by :email,
      mailer: 'MenteeApplicationMailer',
      method: :notify_applicant_of_code_challenge_approved,
      enqueue: true
  end
end
