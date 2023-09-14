class UserMenteeApplication::ApplicationSubmissionNotification < Noticed::Base
  deliver_by :email,
    mailer: 'UserMenteeApplicationMailer',
    method: 'notify_for_application_submission',
    enqueue: true

  param :user_mentee_application
end
