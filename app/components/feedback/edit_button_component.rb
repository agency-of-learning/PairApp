# frozen_string_literal: true

class Feedback::EditButtonComponent < ViewComponent::Base
  VARIANTS = {
    button: 'btn-primary',
    link: 'btn-link btn-xs sm:btn-sm hover:no-underline'
  }.freeze

  def initialize(feedback:, current_user:, style: :button, classes: '')
    @feedback = feedback
    @current_user = current_user
    @style = style
    @classes = classes
  end

  def call
    variant = VARIANTS.fetch(style)

    link_to(
      edit_feedback_path(feedback),
      class: "btn btn-sm capitalize #{variant} #{classes}"
    ) do
      content || 'Edit'
    end
  end

  private

  attr_reader :feedback, :current_user, :style, :classes

  def render?
    feedback.present? && Pundit.policy(current_user, feedback).edit?
  end
end
