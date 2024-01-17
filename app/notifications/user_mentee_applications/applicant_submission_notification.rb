module UserMenteeApplications
  class ApplicantSubmissionNotification < Noticed::Base
    deliver_by :email,
      mailer: 'MenteeApplicationMailer',
      method: 'notify_applicant_of_submission',
      enqueue: true

    param :application
  end
end
