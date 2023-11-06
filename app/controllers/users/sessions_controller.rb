# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :only_authorize_agent

  protected

  def after_sign_in_path_for(user)
    return super(user) unless user.applicant?

    user_mentee_applications_path
  end
end
