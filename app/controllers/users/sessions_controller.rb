# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(user)
    return super(user) unless user.applicant?

    user.mentee_application || new_user_mentee_application_path
  end
end
