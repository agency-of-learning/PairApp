# frozen_string_literal: true

class StandupMeetingGroup::CheckInStatusComponent < ViewComponent::Base
  def initialize(standup_meeting_group, current_user)
    @standup_meeting_group = standup_meeting_group
    @user = current_user
    @standup_meeting = @standup_meeting_group.standup_meetings.find_by(user_id: @user.id, meeting_date: Date.current)
  end
end
