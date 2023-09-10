class LandingController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if current_user.blank?
      render :index
    elsif current_user.applicant?
      # TODO: we technically allow multiple applications but that should be fixed really soon.
      redirect_to user_mentee_application_path(current_user.mentee_application)
    elsif current_user.member? || current_user.admin?
      # TODO: we should have a dashboard home page (the one that shows your standups, pair requests, etc..) for the day
      redirect_to dashboards_path
    end
  end
end
