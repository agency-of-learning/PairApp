# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :only_authorize_agent
end
