# To deliver this notification:
#
# MenteeApplication::ReapplicationNotification.with(post: @post).deliver_later(current_user)
# MenteeApplication::ReapplicationNotification.with(post: @post).deliver(current_user)

class MenteeApplication::ReapplicationNotification < Noticed::Base
  deliver_by :email,
    mailer: 'MenteeApplicationMailer',
    method: :notify_for_reapplication,
    enqueue: true

  param :active_cohort_name
end
