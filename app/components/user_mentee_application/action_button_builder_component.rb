# frozen_string_literal: true

class UserMenteeApplication::ActionButtonBuilderComponent < ViewComponent::Base
  def initialize(mentee_application:, current_user:)
    @mentee_application = mentee_application
    @current_user = current_user
  end

  private

  attr_reader :mentee_application, :current_user

  def render_promote_button
    return unless @mentee_application.current_state.can_promote?
  end

  def render_reject_button
    last_state = @mentee_application.mentee_application_states.last
    return if last_state.rejected?

    button_to 'Reject', user_mentee_application_rejections_path(@mentee_application),
      method: :post,
      class: 'btn btn-primary capitalize btn-link btn-xs sm:btn-sm hover:no-underline'
  end
end
