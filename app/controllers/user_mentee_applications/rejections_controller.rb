class UserMenteeApplications::RejectionsController < ApplicationController
  def create
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])
    @user_mentee_application.rejected!
    @user_mentee_application.status_changed_by_id = current_user.id
  end
end
