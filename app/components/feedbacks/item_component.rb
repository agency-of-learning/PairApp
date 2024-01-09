# frozen_string_literal: true

class Feedbacks::ItemComponent < ViewComponent::Base
  TYPE_HEADINGS = {
    'PairRequest' => 'Pair Programming Feedback',
    'User' => 'User Feedback'
  }.freeze

  def initialize(feedback:, current_user:)
    @feedback = feedback
    @user = current_user
  end

  attr_reader :feedback, :user

  def render?
    Pundit.policy(user, feedback).show?
  end

  def heading_text
    TYPE_HEADINGS.fetch(feedback.referenceable_type)
  end

  def partner_section
    content_tag(:p) do
      if user == feedback.author
        render_partner('For: ', feedback.receiver.full_name)
      else
        render_partner('From: ', feedback.author.full_name)
      end
    end
  end

  def rating_section
    content_tag(:p) do
      feedback.completed? ? render_rating : 'Awaiting completion of feedback.'
    end
  end

  private

  def render_partner(label, partner)
    content_tag(:span, label, class: 'font-bold') + partner
  end

  def render_rating
    content_tag(:span, 'Rating: ', class: 'font-bold') + "#{feedback.overall_rating}/5"
  end
end
