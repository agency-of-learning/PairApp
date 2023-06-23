class StandupMeeting::ActionButtonComponent < ViewComponent::Base
  STATUS_POLICIES = {
    skip: StandupMeeting::SkipPolicy
  }.freeze

  def initialize(standup_meeting:, standup_meeting_group:, current_user:)
    @standup_meeting = standup_meeting
    @standup_meeting_group = standup_meeting_group
    @user = current_user
  end

  private

  attr_reader :user, :standup_meeting, :standup_meeting_group

  def policy(action)
    STATUS_POLICIES.fetch(action).new(user, standup_meeting)
  end
end
