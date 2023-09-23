# Preview all emails at http://localhost:3000/rails/mailers/mentee_application_mailer
class MenteeApplicationMailerPreview < ActionMailer::Preview
  def notify_for_acceptance
    application = UserMenteeApplication.last
    MenteeApplicationMailer.with(recipient: application.user, application:).notify_for_acceptance
  end

  def notify_for_rejection
    MenteeApplicationMailer.with(recipient: User.last).notify_for_rejection
  end

  def notify_for_code_challenge_sent
    MenteeApplicationMailer.with(recipient: User.last).notify_for_code_challenge_sent
  end

  def notify_for_code_challenge_approved
    MenteeApplicationMailer.with(recipient: User.last).notify_for_code_challenge_approved
  end

  def notify_for_reapplication
    MenteeApplicationMailer.with(recipient: User.last,
      active_cohort_name: UserMenteeApplicationCohort.active.name).notify_for_reapplication
  end
end
