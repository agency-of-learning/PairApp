class StandupMeetings::SkipsController < ApplicationController
  def create
    @standup_meeting = StandupMeeting.find(params[:standup_meeting_id])
    # authorize @standup_meeting, policy_class: StandupMeeting::SkipPolicy
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    @standup_meeting.skipped!

    flash[:notice] = "You skipped standup for #{@standup_meeting.meeting_date}"
    redirect_to standup_meeting_group_path(@standup_meeting_group)
  end
end
