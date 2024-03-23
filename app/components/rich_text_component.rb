# frozen_string_literal: true

class RichTextComponent < ViewComponent::Base
  def initialize(rich_text:, user:)
    @rich_text = rich_text
    @user = user
  end

  private

  def user_full_name
    @user.full_name
  end

  # Check to see if the body does not have blank text.
  def render?
    @rich_text.present?
  end
end
