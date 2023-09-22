# To deliver this notification:
#
# MenteeApplication::ReapplicationNotification.with(post: @post).deliver_later(current_user)
# MenteeApplication::ReapplicationNotification.with(post: @post).deliver(current_user)

class MenteeApplication::ReapplicationNotification < Noticed::Base
  deliver_by :email,
    mailer: 'MenteeApplicationMailer',
    method: :notify_for_reapplication,
    enqueue: true

  # Add required params
  #
  param :active_cohort_name

  def active_cohort_name
    params[:active_cohort_name]
  end
end
