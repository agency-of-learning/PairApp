class StandupMeetingGroups::JoinsController < ApplicationController
  def create
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
    @standup_meeting_group_user = @standup_meeting_group.standup_meeting_groups_users.build(user: current_user)

    authorize @standup_meeting_group_user, policy_class: StandupMeetingGroup::JoinPolicy

    @standup_meeting_group_user.save
    # flash[:notice] = 'You have joined this standup meeting group.'

    component = ::StandupMeetingGroup::LeaveButtonComponent.new(standup_meeting_group: @standup_meeting_group,
      current_user:, standup_meeting_group_user: @standup_meeting_group_user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(helpers.dom_id(@standup_meeting_group, :join_or_leave), component)
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
      format.html do
        redirect_to standup_meeting_groups_path
      end
    end
  end
end
