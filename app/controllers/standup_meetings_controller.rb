class StandupMeetingsController < ApplicationController
  def edit
    @standup_meeting = StandupMeeting.includes(:standup_meeting_group)
                                     .find(params[:id])
    @standup_meeting_group = @standup_meeting.standup_meeting_group
    authorize @standup_meeting
  end
end
