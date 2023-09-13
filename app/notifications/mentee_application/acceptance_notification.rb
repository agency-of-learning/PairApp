class MenteeApplication::AcceptanceNotification < Noticed::Base
  deliver_by :email,
    mailer: 'MenteeApplicationMailer',
    method: :notify_for_acceptance,
    enqueue: true
end
