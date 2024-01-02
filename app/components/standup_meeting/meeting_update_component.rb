# frozen_string_literal: true

class StandupMeeting::MeetingUpdateComponent < ViewComponent::Base
  with_collection_parameter :standup_meeting

  def initialize(standup_meeting:, content_type:)
    @standup_meeting = standup_meeting
    @content_type = content_type
  end

  private

  def standup_content
    @standup_content ||= @standup_meeting.public_send(@content_type)
  end

  def user_full_name
    @standup_meeting.user.full_name
  end

  def render?
    standup_content.present?
  end
end
