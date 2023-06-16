# frozen_string_literal: true

class Feedback::EditButtonComponent < ViewComponent::Base
  def initialize(feedback:, current_user:)
    @feedback = feedback
    @current_user = current_user
  end

  private

  attr_reader :feedback, :current_user

  def render?
    feedback.present? && Pundit.policy(current_user, feedback).edit?
  end
end
