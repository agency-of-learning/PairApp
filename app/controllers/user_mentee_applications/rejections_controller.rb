class UserMenteeApplications::RejectionsController < ApplicationController
  def create
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])

    if @user_mentee_application.reject_application!(current_user)
      redirect_to user_mentee_applications_path, notice: 'Successfully rejected.'
    end
  end
end
