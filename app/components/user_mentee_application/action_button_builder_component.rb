# frozen_string_literal: true

class UserMenteeApplication::ActionButtonBuilderComponent < ViewComponent::Base
  attr_reader :mentee_application

  def initialize(mentee_application:)
    @mentee_application = mentee_application
  end

  def render_promote_button
    return unless @mentee_application.current_state.can_promote?

    button_to 'Promote to next stage', user_mentee_application_promotions_path(@mentee_application),
      method: :post,
      class: 'btn btn-primary capitalize btn-link btn-xs sm:btn-sm hover:no-underline'
  end

  def render_reject_button
    last_state = @mentee_application.mentee_application_states.last
    return if last_state&.rejected?

    button_to 'Reject', user_mentee_application_rejections_path(@mentee_application),
      method: :post,
      class: 'btn btn-primary capitalize btn-link btn-xs sm:btn-sm hover:no-underline'
  end

  def call
    concat(render_promote_button)
    concat(render_reject_button)
  end
end
