# To deliver this notification:
#
# MenteeApplication::CodeChallengeNotification.with(post: @post).deliver_later(current_user)
# MenteeApplication::CodeChallengeNotification.with(post: @post).deliver(current_user)

class MenteeApplication::CodeChallengeSentNotification < Noticed::Base
  deliver_by :email,
    mailer: 'MenteeApplicationMailer',
    method: :notify_applicant_of_code_challenge_sent,
    enqueue: true

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
end
