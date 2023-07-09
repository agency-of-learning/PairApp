# frozen_string_literal: true

class StandupMeeting::MeetingColumnComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end

  private

  attr_reader :title
end
