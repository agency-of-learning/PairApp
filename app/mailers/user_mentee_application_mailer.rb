class UserMenteeApplicationMailer < ApplicationMailer

  def notify_for_application_submission
    @user_mentee_application = params[:user_mentee_application]
    @user = @user_mentee_application.user
    mail(to: @user.email, subject: 'Mentee Application Submitted')
  end
end 