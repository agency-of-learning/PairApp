class StandupMeeting::SkipButtonComponent < ViewComponent::Base
  STATUS_POLICIES = {
    skip: StandupMeeting::SkipPolicy
  }.freeze

  def initialize(standup_meeting:, standup_meeting_group:, current_user:)
    @standup_meeting = standup_meeting
    @standup_meeting_group = standup_meeting_group
    @user = current_user
  end

  def call
    button_to(
      'Skip',
      standup_meeting_group_standup_meeting_skips_path(standup_meeting_group, standup_meeting),
      class: 'btn btn-link',
      form_class: 'w-fit'
    )
  end

  private

  attr_reader :user, :standup_meeting, :standup_meeting_group

  def policy(action)
    STATUS_POLICIES.fetch(action).new(user, standup_meeting)
  end

  def render?
    !(standup_meeting.skipped? || standup_meeting.completed?) &&
      policy(:skip).create? && standup_meeting.persisted?
  end
end
