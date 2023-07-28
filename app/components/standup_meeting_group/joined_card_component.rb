# frozen_string_literal: true

class StandupMeetingGroup::JoinedCardComponent < ViewComponent::Base
  with_collection_parameter :standup_meeting_group

  attr_reader :standup_meeting_group, :user

  def initialize(standup_meeting_group:, current_user:)
    @standup_meeting_group = standup_meeting_group
    @user = current_user
    @standup_meeting_group_user = standup_meeting_group.standup_meeting_groups_users.find_by(user:)
    @current_standup_meeting = @user.standup_meetings.find_by(standup_meeting_group: standup_meeting_group)
  end

  def self.checked_in_status
    if @current_standup_meeting
      "Checked in today!"
    else
      "outstanding check in"
    end
  end
end
