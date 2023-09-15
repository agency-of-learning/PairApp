class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include ApplicationHelper
  include Pagy::Backend

  add_flash_types :form_errors

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  # PaperTrail helper for getting current_user
  before_action :set_paper_trail_whodunnit

  around_action :set_time_zone, if: :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_post_actions = %i[accept_invitation account_update sign_up]

    devise_post_actions.each do |action|
      devise_parameter_sanitizer.permit(
        action,
        keys: %i[time_zone first_name last_name]
      )
    end
  end

  private

  def set_time_zone(&)
    Time.use_zone(current_user.time_zone, &)
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    redirect_back(fallback_location: root_path)
  end
end
