# frozen_string_literal: true

class StandupMeeting::DateNavigatorComponent < ViewComponent::Base
  def initialize(standup_meeting_group:, meeting_date:, date_options:)
    @standup_meeting_group = standup_meeting_group
    @meeting_date = meeting_date
    @date_options = date_options
  end

  private

  attr_reader :standup_meeting_group, :meeting_date, :date_options
end
