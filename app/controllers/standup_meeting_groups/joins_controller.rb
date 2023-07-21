class StandupMeetingGroups::JoinsController < ApplicationController
  def create
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    @standup_meeting_group_user = @standup_meeting_group.standup_meeting_groups_users.build(user: current_user)

    authorize @standup_meeting_group_user, policy_class: StandupMeetingGroup::JoinPolicy

    @standup_meeting_group_user.save

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = "You have joined #{@standup_meeting_group.name}!"
        render 'standup_meeting_groups/joins/create'
      end
    end
  end

  def destroy
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    @standup_meeting_group_user = StandupMeetingGroupUser.find(params[:id])

    authorize @standup_meeting_group_user, policy_class: StandupMeetingGroup::JoinPolicy

    @standup_meeting_group_user.destroy

    component = ::StandupMeetingGroup::JoinButtonComponent.new(
      standup_meeting_group: @standup_meeting_group, current_user:
    )

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          helpers.dom_id(@standup_meeting_group, :join_or_leave), component
        )
      end
    end
  end
end
