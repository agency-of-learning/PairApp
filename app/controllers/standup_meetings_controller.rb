class StandupMeetingsController < ApplicationController
  def index
    @meeting_date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    @standup_meetings = @standup_meeting_group.standup_meetings
                                              .includes(:user)
                                              .where(meeting_date: @meeting_date)
    @current_user_standup_meeting = @standup_meetings.find do |meeting|
      meeting.user == current_user
    end || @standup_meeting_group.standup_meetings.new(
      user: current_user,
      meeting_date: @meeting_date
    )
    @completed_meetings = @standup_meetings.filter(&:completed?)
  end

  def edit
    @standup_meeting = StandupMeeting.includes(:standup_meeting_group).find(params[:id])
    @standup_meeting_group = @standup_meeting.standup_meeting_group
    authorize @standup_meeting
  end

  def create
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    authorize @standup_meeting_group, policy_class: StandupMeetingPolicy
    @standup_meeting = @standup_meeting_group.standup_meetings.new(
      user: current_user,
      meeting_date: params[:meeting_date]
    )
    if @standup_meeting.save
      redirect_to edit_standup_meeting_group_standup_meeting_path(@standup_meeting_group, @standup_meeting)
    else
      redirect_back_or_to(
        standup_meeting_group_standup_meetings_path(@standup_meeting_group),
        status: :unprocessable_entity
      )
    end
  end
end
