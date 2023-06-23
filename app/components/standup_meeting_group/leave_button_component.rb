class StandupMeetingGroup::LeaveButtonComponent < StandupMeetingGroup::BaseButtonComponent
  def after_initialize(standup_meeting_group_user:)
    @standup_meeting_group_user = standup_meeting_group_user
  end

  private

  attr_reader :standup_meeting_group_user
end
