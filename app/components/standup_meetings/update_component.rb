# frozen_string_literal: true

class StandupMeetings::UpdateComponent < ViewComponent::Base
  with_collection_parameter :update

  # +update+ is a string/text
  # +owner+ is a User instance
  def initialize(update:, owner:)
    @update = update
    @owner = owner
  end

  private

  attr_reader :update

  # Some content may be intentionally empty.
  # e.g. Standup update blockers are often empty.
  def render?
    @update.present?
  end

  def owner_name
    @owner.full_name
  end
end
