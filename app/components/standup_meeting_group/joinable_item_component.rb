# frozen_string_literal: true

class StandupMeetingGroup::JoinableItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  with_collection_parameter :standup_meeting_group

  attr_reader :standup_meeting_group, :user

  def initialize(standup_meeting_group:, current_user:)
    @standup_meeting_group = standup_meeting_group
    @user = current_user
  end
end
