# frozen_string_literal: true

class UserMenteeApplication::ActionButtonBuilderComponent < ViewComponent::Base
  attr_reader :mentee_application

  def initialize(mentee_application:)
    @mentee_application = mentee_application
  end

  def button_text
    @mentee_application.mentee_application_states.last.next_status
  end

  def render_button
    last_status = @mentee_application.mentee_application_states.last.status.to_sym
    max_index = MenteeApplicationState::STATUSES.keys.length - 1
    current_index = MenteeApplicationState::STATUSES.keys.index(last_status)

    if current_index < max_index
      button_to button_text, user_mentee_application_promotions_path(@mentee_application),
        method: :post,
        class: 'btn btn-primary capitalize btn-link btn-xs sm:btn-sm hover:no-underline'
    else
      'Accepted'
    end
  end

  private

  def application_in_final_state?
    current_status_index = MenteeApplicationState::STATUSES
                           .keys.index(@mentee_application.mentee_application_states.last.status.to_sym)
    last_status_index = MenteeApplicationState::STATUSES.keys.length - 1
    current_status_index > last_status_index
  end
end
