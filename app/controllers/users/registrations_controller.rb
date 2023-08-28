# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # POST /resource
  def create
    super(&:applicant!)
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[time_zone first_name last_name])
  end

  def after_sign_up_path_for(_resource)
    new_user_mentee_application_path
  end
end
