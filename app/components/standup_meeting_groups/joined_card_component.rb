# frozen_string_literal: true

class StandupMeetingGroups::JoinedCardComponent < ViewComponent::Base
  with_collection_parameter :standup_meeting_group

  attr_reader :standup_meeting_group, :user

  def initialize(standup_meeting_group:, current_user:)
    @standup_meeting_group = standup_meeting_group
    @user = current_user
    @standup_meeting_group_user = standup_meeting_group.standup_meeting_groups_users.find_by(user:)
  end

  def standup_meeting
    existing_meeting = standup_meeting_group.standup_meetings.detect do |meeting|
      meeting.meeting_date == Date.current && meeting.user == user
    end

    existing_meeting || standup_meeting_group.standup_meetings.build(user:, meeting_date: Date.current)
  end
end
