# frozen_string_literal: true

class StandupMeetingGroups::JoinableItemComponent < ViewComponent::Base
  include Turbo::FramesHelper

  with_collection_parameter :standup_meeting_group

  attr_reader :standup_meeting_group, :standup_meeting_group_user, :my_standup_meeting_groups

  def initialize(standup_meeting_group:, my_standup_meeting_groups:, current_user:)
    @standup_meeting_group = standup_meeting_group
    @my_standup_meeting_groups = my_standup_meeting_groups
    @standup_meeting_group_user = standup_meeting_group.standup_meeting_groups_users.find_by(user: current_user)
  end
end
