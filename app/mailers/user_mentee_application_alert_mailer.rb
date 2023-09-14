class UserMenteeApplicationAlertMailer < ApplicationMailer
  def notify_for_application_submission
    @user_mentee_application = params[:application]
    mail(subject: 'New Application submission!')
  end
end
