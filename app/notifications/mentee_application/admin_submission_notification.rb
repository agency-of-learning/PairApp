class MenteeApplication::AdminSubmissionNotification < Noticed::Base
  deliver_by :email,
    mailer: 'MenteeApplicationMailer',
    method: 'notify_admin_of_submission',
    enqueue: true

  param :application
end
