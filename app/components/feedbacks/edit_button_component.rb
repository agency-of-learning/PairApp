# frozen_string_literal: true

class Feedbacks::EditButtonComponent < ViewComponent::Base
  VARIANTS = {
    button: 'btn-primary',
    link: 'btn-link btn-xs sm:btn-sm hover:no-underline'
  }.freeze

  def initialize(feedback:, current_user:, style: :button, class_names: '', data: {})
    @feedback = feedback
    @current_user = current_user
    @style = style
    @class_names = class_names
    @data = data
  end

  def call
    variant = VARIANTS.fetch(style)

    link_to(
      edit_feedback_path(feedback),
      class: "btn btn-sm capitalize #{variant} #{class_names}",
      data:
    ) do
      content || 'Edit'
    end
  end

  private

  attr_reader :feedback, :current_user, :style, :class_names, :data

  def render?
    feedback.present? && Pundit.policy(current_user, feedback).edit?
  end
end
