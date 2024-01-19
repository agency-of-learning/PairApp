# To deliver this notification:
#
# UserMenteeApplications::CodeChallengeNotification
#   .with(post: @post).deliver_later(current_user)
# UserMenteeApplications::CodeChallengeNotification
#   .with(post: @post).deliver(current_user)

module UserMenteeApplications
  class CodeChallengeSentNotification < Noticed::Base
    deliver_by :email,
      mailer: 'MenteeApplicationMailer',
      method: :notify_applicant_of_code_challenge_sent,
      enqueue: true
  end
end
