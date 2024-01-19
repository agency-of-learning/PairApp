# frozen_string_literal: true

class StandupMeetings::ColumnComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end

  private

  attr_reader :title
end
