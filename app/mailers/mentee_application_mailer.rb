class MenteeApplicationMailer < ApplicationMailer
  default from: 'dave@agencyoflearning.com', bcc: 'dave@agencyoflearning.com'

  def notify_applicant_of_submission
    @application = params[:application]
    mail(subject: 'Woohoo! We got your application to the Agency of Learning')
  end

  def notify_admin_of_submission
    @application = params[:application]
    mail(
      subject: "[#{@application.cohort.name} Cohort Submission] #{@application.user.full_name}",
      bcc: nil,
      from: 'no_reply@agencyoflearning.com'
    )
  end

  def notify_applicant_of_code_challenge_sent
    mail(subject: 'Moving forward in the application process for the Agency of Learning')
  end

  def notify_applicant_of_code_challenge_approved
    mail(subject: 'Moving forward in the application process for the Agency of Learning')
  end

  def notify_applicant_of_acceptance
    @application = params[:application]
    mail(subject: 'Welcome to the Agency of Learning!')
  end

  def notify_applicant_of_rejection
    mail(subject: 'Update on your application to the Agency of Learning')
  end

  def notify_applicant_to_reapply
    @active_cohort_name = params[:active_cohort_name]
    mail(subject: 'Invitation to Apply to the Agency of Learning')
  end
end
