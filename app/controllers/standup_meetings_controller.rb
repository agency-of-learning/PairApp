class StandupMeetingsController < ApplicationController
  def index
    @meeting_date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    @standup_meetings = @standup_meeting_group.standup_meetings
                                              .includes(:user)
                                              .where(meeting_date: @meeting_date)
    @current_user_standup_meeting = @standup_meetings.find do |meeting|
      meeting.user == current_user
    end
    @completed_meetings = @standup_meetings.filter(&:completed?)
  end

  def edit
    @standup_meeting = StandupMeeting.includes(:standup_meeting_group).find(params[:id])
    @standup_meeting_group = @standup_meeting.standup_meeting_group
    authorize @standup_meeting
  end
end
