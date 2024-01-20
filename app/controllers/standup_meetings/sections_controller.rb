class StandupMeetings::SectionsController < ApplicationController
  def index
    @standup_meeting = StandupMeeting.find(params[:standup_meeting_id])
    @section = params[:section]

    if @standup_meeting.allowed_section?(@section)
      @question = @standup_meeting.send(@section)
    else
      flash[:alert] = 'Invalid section'
      redirect_to standup_meeting_group_standup_meetings_path(@standup_meeting.group)
    end
  end
end
