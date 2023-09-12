# Preview all emails at http://localhost:3000/rails/mailers/mentee_application_mailer
class MenteeApplicationMailerPreview < ActionMailer::Preview
  def notify_for_acceptance
    MenteeApplicationMailer.with(recipient: User.last).notify_for_acceptance
  end
end
