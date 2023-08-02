# frozen_string_literal: true

class StandupMeetingGroup::CheckInStatusComponent < ViewComponent::Base
  def initialize(standup_meeting_group, current_user)
    @standup_meeting_group = standup_meeting_group
    user = current_user

    @checked_in = user.standup_meetings.find_by(standup_meeting_group: standup_meeting_group)
  end
end
