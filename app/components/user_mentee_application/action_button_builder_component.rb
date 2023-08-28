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
    max_index = MenteeApplicationState::STATUSES.keys.length - 2
    current_index = MenteeApplicationState::STATUSES.keys.index(last_status)

    if current_index < max_index && last_status != :rejected
      button_to 'Promote to next stage', user_mentee_application_promotions_path(@mentee_application),
        method: :post,
        class: 'btn btn-primary capitalize btn-link btn-xs sm:btn-sm hover:no-underline'
    elsif last_status == :rejected
      button_to 'Restore Application', user_mentee_application_promotions_path(@mentee_application),
        method: :post,
        class: 'btn btn-primary capitalize btn-link btn-xs sm:btn-sm hover:no-underline'
    end
  end

  def render_reject_button
    last_state = @mentee_application.mentee_application_states.last
    return if last_state&.rejected?

    button_to 'Reject', user_mentee_application_rejections_path(@mentee_application),
      method: :post,
      class: 'btn btn-primary capitalize btn-link btn-xs sm:btn-sm hover:no-underline'
  end

  # def call
  #   render_button + render_reject_button
  # end

  private

  def application_in_final_state?
    current_status_index = MenteeApplicationState::STATUSES
                           .keys.index(@mentee_application.mentee_application_states.last.status.to_sym)
    last_status_index = MenteeApplicationState::STATUSES.keys.length - 1
    current_status_index > last_status_index
  end
end
