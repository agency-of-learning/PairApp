# frozen_string_literal: true

class StandupMeeting::ButtonGroupComponent < ViewComponent::Base
  def initialize(standup_meeting_group:, standup_meeting:, current_user:)
    @standup_meeting_group = standup_meeting_group
    @standup_meeting = standup_meeting
    @user = current_user
  end

  attr_reader :standup_meeting, :standup_meeting_group, :user
end
