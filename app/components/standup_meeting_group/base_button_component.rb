# frozen_string_literal: true

class StandupMeetingGroup::BaseButtonComponent < ViewComponent::Base
  def self.for(standup_meeting_group:, current_user:)
    standup_meeting_group_user = standup_meeting_group.standup_meeting_group_user(current_user.id)

    klass_name = standup_meeting_group_user.present? ? 'LeaveButtonComponent' : 'JoinButtonComponent'

    "StandupMeetingGroup::#{klass_name}".safe_constantize.new(standup_meeting_group:, current_user:,
      standup_meeting_group_user:)
  end

  protected

  attr_reader :standup_meeting_group, :user

  def initialize(standup_meeting_group:, current_user:, **args)
    @standup_meeting_group = standup_meeting_group
    @user = current_user

    after_initialize(**args)
  end

  def after_initialize(**); end
end
