# Preview all emails at http://localhost:3000/rails/mailers/mentee_application_mailer
class MenteeApplicationMailerPreview < ActionMailer::Preview
  def notify_applicant_of_submission
    application = UserMenteeApplication.last
    MenteeApplicationMailer.with(recipient: application.user, application:).notify_applicant_of_submission
  end

  def notify_admin_of_submission
    application = UserMenteeApplication.last
    MenteeApplicationMailer.with(recipient: User.admin.last, application:).notify_admin_of_submission
  end

  def notify_applicant_of_acceptance
    application = UserMenteeApplication.last
    MenteeApplicationMailer.with(recipient: application.user, application:).notify_applicant_of_acceptance
  end

  def notify_applicant_of_rejection
    MenteeApplicationMailer.with(recipient: User.last).notify_applicant_of_rejection
  end

  def notify_applicant_of_code_challenge_sent
    MenteeApplicationMailer.with(recipient: User.last).notify_applicant_of_code_challenge_sent
  end

  def notify_applicant_of_code_challenge_approved
    MenteeApplicationMailer.with(recipient: User.last).notify_applicant_of_code_challenge_approved
  end

  def notify_applicant_to_reapply
    MenteeApplicationMailer.with(recipient: User.last,
      active_cohort_name: UserMenteeApplicationCohort.active.name).notify_applicant_to_reapply
  end

  def notify_applicant_of_withdrawal
    MenteeApplicationMailer.with(recipient: User.last).notify_applicant_of_withdrawal
  end
end
