class StandupMeetings::SectionsController < ApplicationController
  def index
    @standup_meeting = StandupMeeting.find(params[:standup_meeting_id])
    @section = params[:section]
    @question = @standup_meeting.send(@section)
  end
end
