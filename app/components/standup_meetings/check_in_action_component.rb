# frozen_string_literal: true

class StandupMeetings::CheckInActionComponent < ViewComponent::Base
  def initialize(standup_meeting_group:, standup_meeting:)
    @standup_meeting_group = standup_meeting_group
    @standup_meeting = standup_meeting
  end

  private

  attr_reader :standup_meeting, :standup_meeting_group

  # A non-persisted record can have status: "completed". Remember to check for
  # persistence before checking the status.
  def standup_meeting_exists?
    standup_meeting.persisted?
  end

  def action
    standup_meeting.completed? ? 'Edit' : 'Check in'
  end

  def edit_standup_meeting_path
    edit_standup_meeting_group_standup_meeting_path(
      standup_meeting_group,
      standup_meeting
    )
  end

  def create_standup_meeting_path
    standup_meeting_group_standup_meetings_path(
      standup_meeting_group,
      meeting_date: standup_meeting.meeting_date
    )
  end
end
