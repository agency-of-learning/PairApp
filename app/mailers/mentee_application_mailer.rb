class MenteeApplicationMailer < ApplicationMailer
  def notify_for_acceptance
    mail(subject: 'Welcome to the Agency of Learning!')
  end
end
