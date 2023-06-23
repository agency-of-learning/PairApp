class StandupMeetings::CompletionsController < ApplicationController
  def create
    @standup_meeting = StandupMeeting.find(params[:standup_meeting_id])
    authorize @standup_meeting, policy_class: StandupMeeting::CompletionPolicy
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])

    if @standup_meeting.update(standup_meeting_params)
      flash[:notice] = "You completed the standup for #{@standup_meeting.meeting_date}"
      redirect_to standup_meeting_group_path(@standup_meeting_group)
    else
      flash[:form_errors] = @standup_meeting.errors.full_messages
      redirect_to edit_standup_meeting_group_standup_meeting_path(@standup_meeting_group, @standup_meeting)
    end
  end

  private

  def standup_meeting_params
    params.require(:standup_meeting).permit(:meeting_date, :yesterday_work_description, :today_work_description, :blockers_description, :status)
  end
end
