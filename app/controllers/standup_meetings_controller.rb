class StandupMeetingsController < ApplicationController
  before_action :set_standup_meeting_group

  def index
    @meeting_date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @standup_meetings = StandupMeeting.includes(:user, :standup_meeting_group)
                                      .completed
                                      .where(
                                        meeting_date: @meeting_date,
                                        standup_meeting_group_id: params[:standup_meeting_group_id]
                                      )
    @standup_meeting_group = @standup_meetings.first.standup_meeting_group
  end

  def edit
    @standup_meeting = StandupMeeting.find(params[:id])
    authorize @standup_meeting
  end
end
