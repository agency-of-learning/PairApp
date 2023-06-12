class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include ApplicationHelper

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?


  # PaperTrail helper for getting current_user
  before_action :set_paper_trail_whodunnit

  around_action :set_time_zone, if: :current_user


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:time_zone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:time_zone])
  end
  
  private
  def set_time_zone(&)
    Time.use_zone(current_user.time_zone, &)
  end
end
