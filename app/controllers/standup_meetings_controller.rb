class StandupMeetingsController < ApplicationController
  def index
    @meeting_date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @standup_meetings = StandupMeeting.includes(:user, :standup_meeting_group)
                                      .where(
                                        meeting_date: @meeting_date,
                                        standup_meeting_group_id: params[:standup_meeting_group_id]
                                      )
    @completed_meetings = @standup_meetings.filter(&:completed?)
    @current_user_standup_meeting = @standup_meetings.find { |meet| meet.user == current_user }
    @standup_meeting_group = StandupMeetingGroupDecorator.new(@standup_meetings.first.standup_meeting_group)
  end

  def edit
    @standup_meeting = StandupMeeting.includes(:standup_meeting_group).find(params[:id])
    @standup_meeting_group = @standup_meeting.standup_meeting_group
    authorize @standup_meeting
  end
end
