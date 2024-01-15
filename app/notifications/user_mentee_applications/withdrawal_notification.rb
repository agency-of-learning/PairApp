module UserMenteeApplications
  class WithdrawalNotification < Noticed::Base
    deliver_by :email,
      mailer: 'MenteeApplicationMailer',
      method: :notify_applicant_of_withdrawal,
      enqueue: true
  end
end
