# To deliver this notification:
#
# MenteeApplication::RejectionNotification.with(post: @post).deliver_later(current_user)
# MenteeApplication::RejectionNotification.with(post: @post).deliver(current_user)

class MenteeApplication::RejectionNotification < Noticed::Base
  deliver_by :email,
    mailer: 'MenteeApplicationMailer',
    method: :notify_applicant_of_rejection,
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
