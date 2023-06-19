# frozen_string_literal: true

class Feedback::ContainerComponent < ViewComponent::Base
  def initialize(feedback:, current_user:)
    @feedback = feedback
    @user = current_user
  end

  attr_reader :feedback, :user

  def render?
    feedback.present?
  end

  def heading(class:)
    text = feedback.author == user ? 'Given Feedback' : 'Received Feedback'
    content_tag(:h2, text, class:)
  end

  def questions
    feedback.data['feedback']
  end
end
