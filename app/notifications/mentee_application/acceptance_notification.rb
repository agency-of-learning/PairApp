class MenteeApplication::AcceptanceNotification < Noticed::Base
  deliver_by :email,
    mailer: 'MenteeApplicationMailer',
    method: :notify_applicant_of_acceptance,
    enqueue: true
end
