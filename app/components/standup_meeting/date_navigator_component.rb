# frozen_string_literal: true

class StandupMeeting::DateNavigatorComponent < ViewComponent::Base
  def initialize(standup_meeting_group:, meeting_date:)
    @standup_meeting_group = standup_meeting_group
    @meeting_date = meeting_date
  end

  private

  attr_reader :standup_meeting_group, :meeting_date, :date_options

  def next_standup_meeting
    meeting_date.tomorrow
  end

  def next_standup_meeting?
    next_standup_meeting.present?
  end

  def previous_standup_meeting
    meeting_date.yesterday
  end

  def previous_standup_meeting?
    previous_standup_meeting.present?
  end
end
