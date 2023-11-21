class Admin::UserMenteeApplicationsController < ApplicationController
  before_action -> { authorize :user_only, :application_reviewer? }

  def show
    @user_mentee_application = UserMenteeApplication.find(params[:id])
  end
end
