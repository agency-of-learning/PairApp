class StandupMeetingGroups::JoinsController < ApplicationController
  # POST /standup_meeting_groups/:standup_meeting_group_id/joins.turbo_stream
  def create
    @standup_meeting_group = StandupMeetingGroup.includes(:standup_meetings)
                                                .find(params[:standup_meeting_group_id])
    @standup_meeting_group_user = @standup_meeting_group.standup_meeting_groups_users.build(user: current_user)
    @my_standup_meeting_groups = policy_scope(StandupMeetingGroup).includes(:standup_meeting_groups_users,
      :standup_meetings)

    authorize @standup_meeting_group_user, policy_class: StandupMeetingGroup::JoinPolicy

    join_message = "You have joined #{@standup_meeting_group.name}!"
    flash.now[:notice] = join_message if @standup_meeting_group_user.save
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
