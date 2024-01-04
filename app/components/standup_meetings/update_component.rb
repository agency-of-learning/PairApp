# frozen_string_literal: true

class StandupMeetings::UpdateComponent < ViewComponent::Base
  with_collection_parameter :rich_text_with_reaction

  def initialize(standup_meeting:, content_type:)
    @standup_meeting = standup_meeting
    @content_type = content_type
    @user = standup_meeting.user
  end

  private

  def standup_content
    @standup_content ||= standup_meeting.public_send(@content_type)
  end

  def user_full_name
    @user.full_name
  end

  def render?
    standup_content.present?
  end
end
