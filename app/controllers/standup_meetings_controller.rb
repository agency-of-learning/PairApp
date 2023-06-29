class StandupMeetingsController < ApplicationController
  before_action :set_standup_meeting_group

  def index
    @meeting_date = params[:date] || Date.current
    @standup_meetings = StandupMeeting.includes(:user)
                                      .completed
                                      .where(
                                        meeting_date: @meeting_date,
                                        standup_meeting_group: @standup_meeting_group
                                      )
  end

  def edit
    @standup_meeting = StandupMeeting.find(params[:id])
    authorize @standup_meeting
  rescue Pundit::NotAuthorizedError
    redirect_back_or_to(standup_meeting_groups_path)
  end

  private

  def set_standup_meeting_group
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
  end
end
