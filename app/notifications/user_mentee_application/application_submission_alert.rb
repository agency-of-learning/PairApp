class UserMenteeApplication::ApplicationSubmissionAlert < Noticed::Base
  deliver_by :email,
    mailer: 'UserMenteeApplicationAlertMailer',
    method: 'notify_for_application_submission',
    enqueue: true

  param :user_mentee_application
end
