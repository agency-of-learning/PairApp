class StandupMeetingGroup::CheckInButtonComponent < ViewComponent::Base
  def initialize(standup_meeting_group)
    @standup_meeting_group = standup_meeting_group
  end
end

# Q: whi am i getting this error? uninitialized constant StandupMeetingGroup::CheckInButtonComponent
