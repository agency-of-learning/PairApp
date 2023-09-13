class UserMenteeApplicationMailer < ApplicationMailer
  def notify_for_application_submission
    @user_mentee_application = params[:user_mentee_application]
    mail(subject: 'Mentee Application Submitted')
  end
end
