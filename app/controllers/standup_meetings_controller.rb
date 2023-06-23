class StandupMeetingsController < ApplicationController
  before_action :set_standup_meeting_group

  def edit
    @standup_meeting = StandupMeeting.find(params[:id])
    # TODO: A naïve date range with a single min and max is probably fine for now,
    # but there is an islands and gaps problem that should be handled to address
    # issues when a user joins a group, leaves the group, and rejoins.
    @date_range = [{
      from: StandupMeeting.for_member(current_user, @standup_meeting_group).minimum(:meeting_date),
      to: StandupMeeting.for_member(current_user, @standup_meeting_group).maximum(:meeting_date)
    }]
  end

  private

  def set_standup_meeting_group
    @standup_meeting_group = StandupMeetingGroup.find(params[:standup_meeting_group_id])
  end
end
