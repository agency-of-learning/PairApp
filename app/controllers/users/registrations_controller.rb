# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :only_authorize_agent

  protected

  def after_sign_up_path_for(_resource)
    user_mentee_applications_path
  end
end
