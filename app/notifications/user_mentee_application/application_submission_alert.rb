class UserMenteeApplication::ApplicationSubmissionAlert < Noticed::Base
    deliver_by :email,
     mailer: "UserMenteeApplicationAlertMailer",
    method: "notify_for_application_submission"

  param :user_mentee_application
end
