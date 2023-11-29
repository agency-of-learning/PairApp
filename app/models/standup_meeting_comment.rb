class StandupMeetingComment < ApplicationRecord
  belongs_to :standup_meeting

  has_rich_text :content
end
