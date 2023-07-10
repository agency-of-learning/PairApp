# frozen_string_literal: true

class StandupMeeting::MeetingUpdateComponent < ViewComponent::Base
  with_collection_parameter :standup_meeting

  def initialize(standup_meeting:, content_type:)
    @standup_meeting = standup_meeting
    @content_type = content_type
    @user = standup_meeting.user
  end

  private

  attr_reader :standup_meeting, :content_type, :user
end
