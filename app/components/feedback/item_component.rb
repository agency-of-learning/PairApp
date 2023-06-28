# frozen_string_literal: true

class Feedback::ItemComponent < ViewComponent::Base
  TYPE_HEADINGS = {
    'PairRequest' => 'Pair Programming Feedback',
    'User' => 'User Feedback'
  }.freeze

  def initialize(feedback:, current_user:)
    @feedback = feedback
    @user = current_user
  end

  attr_reader :feedback, :user

  def heading_text
    TYPE_HEADINGS.fetch(feedback.referenceable_type)
  end

  def partner_label
    user == feedback.author ? 'For' : 'From'
  end
end
