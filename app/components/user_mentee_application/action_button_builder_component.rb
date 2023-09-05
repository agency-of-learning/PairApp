# frozen_string_literal: true

class UserMenteeApplication::ActionButtonBuilderComponent < ViewComponent::Base
  def initialize(mentee_application:, current_user:)
    @mentee_application = mentee_application
    @current_user = current_user
  end

  private

  attr_reader :mentee_application, :current_user
end
