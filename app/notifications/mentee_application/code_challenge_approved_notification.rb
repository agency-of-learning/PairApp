# To deliver this notification:
#
# MenteeApplication::CodeChallengeApprovedNotification.with(post: @post).deliver_later(current_user)
# MenteeApplication::CodeChallengeApprovedNotification.with(post: @post).deliver(current_user)

class MenteeApplication::CodeChallengeApprovedNotification < Noticed::Base
  deliver_by :email,
    mailer: 'MenteeApplicationMailer',
    method: :notify_applicant_of_code_challenge_approved,
    enqueue: true
end
