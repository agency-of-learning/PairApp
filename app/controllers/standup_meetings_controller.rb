class StandupMeetingsController < ApplicationController
  before_action :set_standup_meeting_group

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
