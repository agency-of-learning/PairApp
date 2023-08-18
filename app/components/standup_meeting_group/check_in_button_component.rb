class StandupMeetingGroup::CheckInButtonComponent < ViewComponent::Base
  def initialize(standup_meeting_group)
    super
    @standup_meeting_group = standup_meeting_group
  end
end
