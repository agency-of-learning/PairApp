# Preview all emails at http://localhost:3000/rails/mailers/mentee_application_mailer
class MenteeApplicationMailerPreview < ActionMailer::Preview
  def notify_for_acceptance
    application = UserMenteeApplication.last
    MenteeApplicationMailer.with(recipient: application.user, application:).notify_for_acceptance
  end

  def notify_for_rejection
    MenteeApplicationMailer.with(recipient: User.last).notify_for_rejection
  end
end
