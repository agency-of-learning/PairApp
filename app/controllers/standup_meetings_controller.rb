class StandupMeetingsController < ApplicationController
  def index
    @meeting_date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @standup_meetings = StandupMeeting.includes(:user, :standup_meeting_group)
                                      .where(
                                        meeting_date: @meeting_date,
                                        standup_meeting_group_id: params[:standup_meeting_group_id]
                                      )
    @date_options = StandupMeeting.meeting_dates(params[:standup_meeting_group_id])
    if @standup_meetings.empty?
      flash[:alert] = 'There are no standups for the date you selected'
      redirect_to standup_meeting_group_standup_meetings_path(params[:standup_meeting_group_id],
        date: @date_options.max)
    else
      @completed_meetings = @standup_meetings.filter(&:completed?)
      @standup_meeting_group = @standup_meetings.first.standup_meeting_group
    end
  end

  def edit
    @standup_meeting = StandupMeeting.includes(:standup_meeting_group).find(params[:id])
    @standup_meeting_group = @standup_meeting.standup_meeting_group
    authorize @standup_meeting
  end
end
