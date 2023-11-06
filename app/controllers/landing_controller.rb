class LandingController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :only_authorize_agent

  def index
    if current_user.blank?
      render :index
    elsif current_user.applicant?
      redirect_to user_mentee_applications_path
    elsif current_user.member? || current_user.admin?
      # TODO: we should have a dashboard home page (the one that shows your standups, pair requests, etc..) for the day
      redirect_to dashboards_path
    end
  end
end
