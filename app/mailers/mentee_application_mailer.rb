class MenteeApplicationMailer < ApplicationMailer
  def notify_for_acceptance
    @application = params[:application]
    mail(subject: 'Welcome to the Agency of Learning!')
  end

  def notify_for_rejection
    mail(subject: 'Update on your application to the Agency of Learning')
  end

  def notify_for_code_challenge_sent
    mail(subject: 'Moving forward in the application process for the Agency of Learning')
  end

  def notify_for_code_challenge_approved
    mail(subject: 'Moving forward in the application process for the Agency of Learning')
  end
end
