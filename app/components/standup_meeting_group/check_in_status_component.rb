# frozen_string_literal: true

class StandupMeetingGroup::CheckInStatusComponent < ViewComponent::Base
  ICON_STYLES = {
    small: 'mr-1',
    large: 'mr-4'
  }.freeze

  TEXT_STYLES = {
    small: 'text-sm',
    large: 'text-xl'
  }.freeze

  def initialize(standup_meeting_group:, current_user:, variant: :small)
    @standup_meeting_group = standup_meeting_group
    @user = current_user
    @standup_meeting = @standup_meeting_group.standup_meetings.find_by(user_id: @user.id, meeting_date: Date.current)
    @variant = variant
  end

  attr_reader :variant

  private

  def p_tag_classes
    TEXT_STYLES.fetch(variant)
  end

  def icon_classes
    ICON_STYLES.fetch(variant)
  end
end
