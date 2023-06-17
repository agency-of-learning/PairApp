class StandupMeetingGroups::JoinsController < ApplicationController
  def create
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    @standup_meeting_group_user = @standup_meeting_group.standup_meeting_groups_users.build(user: current_user)

    authorize @standup_meeting_group_user, policy_class: StandupMeetingGroup::JoinPolicy

    @standup_meeting_group_user.save
    flash[:notice] = 'You have joined this standup meeting group.'
    redirect_to standup_meeting_group_path(@standup_meeting_group)
  end

  def destroy
    @standup_meeting_group_user = StandupMeetingGroupUser.find(params[:id])

    authorize @standup_meeting_group_user, policy_class: StandupMeetingGroup::JoinPolicy

    @standup_meeting_group_user.destroy
    flash[:notice] = 'You have left this standup meeting group.'
    redirect_to standup_meeting_groups_path
  end
end
