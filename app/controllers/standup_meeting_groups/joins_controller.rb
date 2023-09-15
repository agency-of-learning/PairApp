class StandupMeetingGroups::JoinsController < ApplicationController
  def create
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    @standup_meeting_group_user = @standup_meeting_group.standup_meeting_groups_users.build(user: current_user)
    @my_standup_meeting_groups = policy_scope(StandupMeetingGroup).includes(:standup_meeting_groups_users,
      :standup_meetings)

    authorize @standup_meeting_group_user, policy_class: StandupMeetingGroup::JoinPolicy

    @standup_meeting_group_user.save!

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = "You have joined #{@standup_meeting_group.name}!"
      end
    end
  end

  def destroy
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    @standup_meeting_group_user = StandupMeetingGroupUser.find(params[:id])
    @my_standup_meeting_groups = policy_scope(StandupMeetingGroup).includes(:standup_meeting_groups_users,
      :standup_meetings)

    authorize @standup_meeting_group_user, policy_class: StandupMeetingGroup::JoinPolicy

    @standup_meeting_group_user.destroy
    respond_to do |format|
      format.html { redirect_to standup_meeting_groups_path, notice: 'You have left the standup meeting group.' }
    end
  end
end
