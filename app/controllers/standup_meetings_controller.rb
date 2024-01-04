class StandupMeetingsController < ApplicationController
  # rubocop:disable Metrics/AbcSize
  def index
    begin
      @meeting_date = Date.strptime(params[:date], '%m-%d-%Y')
    rescue StandardError
      redirect_to standup_meeting_group_standup_meetings_path(params[:standup_meeting_group_id],
        date: Date.current.strftime('%m-%d-%Y'))
    end

    @standup_meeting_group = StandupMeetingGroup.includes(:users)
                                                .find(params[:standup_meeting_group_id])
    authorize @standup_meeting_group, policy_class: StandupMeetingPolicy
    @standup_meetings = @standup_meeting_group
                        .standup_meetings
                        .includes(:user,
                          :rich_text_yesterday_work_description,
                          :rich_text_today_work_description,
                          :rich_text_blockers_description)
                        .where(meeting_date: @meeting_date)
    @current_user_standup_meeting = @standup_meetings.detect do |meeting|
      meeting.user == current_user
    end || @standup_meeting_group.standup_meetings.new(
      user: current_user,
      meeting_date: @meeting_date
    )
    @completed_meetings = @standup_meetings.filter(&:completed?)
  end
  # rubocop:enable Metrics/AbcSize

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
