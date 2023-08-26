class UserMenteeApplications::AcceptancesController < ApplicationController
  def create
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])
    @user_mentee_application.accepted!
  end
end
