class UserMenteeApplication::ApplicationSubmissionAlert < Noticed::Base
  deliver_by :email,
    mailer: 'UserMenteeApplicationMailer',
    method: 'notify_for_application_submission',
    enqueue: true

  param :application
end
