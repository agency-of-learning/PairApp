# frozen_string_literal: true

class StandupMeetings::RowComponent < ViewComponent::Base
  with_collection_parameter :standup_meeting

  def initialize(standup_meeting:)
    @standup_meeting = standup_meeting
  end

  private

  attr_reader :standup_meeting
end
