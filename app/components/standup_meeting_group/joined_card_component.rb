# frozen_string_literal: true

class StandupMeetingGroup::JoinedCardComponent < ViewComponent::Base
  with_collection_parameter :standup_meeting_group

  attr_reader :standup_meeting_group, :user

  def initialize(standup_meeting_group:, current_user:)
    @standup_meeting_group = standup_meeting_group
    @user = current_user
  end

  def card_class_names
    "card card-bordered w-72 #{background_color}"
  end

  private

  def background_color
    'bg-green-200'
  end
end
