class UserMenteeApplications::PromotionsController < ApplicationController
  def create
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])

    if @user_mentee_application.promote_application!(current_user)
      redirect_to user_mentee_applications_path, notice: 'Successfully promoted to next stage.'
    else
      redirect_to user_mentee_applications_path, alert: 'Failed to promote.'
    end
  end
end
