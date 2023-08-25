# frozen_string_literal: true

class UserMenteeApplication::ActionButtonBuilderComponent < ViewComponent::Base
  def initialize(user_mentee_application:)
    @user_mentee_application = user_mentee_application
  end

  def button_text
    @user_mentee_application.mentee_application_states.last.next_status
  end

  def button_path
    @user_mentee_application.mentee_application_states.last.next_status
  end
end
