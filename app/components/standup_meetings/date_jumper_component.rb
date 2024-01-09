# frozen_string_literal: true

class StandupMeetings::DateJumperComponent < ViewComponent::Base
  def initialize(standup_meeting_group:, meeting_date:)
    @standup_meeting_group = standup_meeting_group
    @meeting_date = meeting_date
  end

  private

  attr_reader :standup_meeting_group

  def meeting_date
    @meeting_date.to_date.strftime('%m-%d-%Y')
  end

  def base_url
    standup_meeting_group_standup_meetings_path(standup_meeting_group)
  end

  def default_url
    base_url + "?date=#{meeting_date}"
  end
end
