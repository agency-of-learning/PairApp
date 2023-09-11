# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    user_mentee_applications_path
  end
end
