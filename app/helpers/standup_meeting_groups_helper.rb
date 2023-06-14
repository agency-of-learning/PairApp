module StandupMeetingGroupsHelper
  def joined_text?(standup_meeting_group)
    joined_status = standup_meeting_group.joined?(current_user.id)

    joined_status ? 'Leave' : 'Join'
  end
end
