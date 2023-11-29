class StandupMeetingComment < ApplicationRecord
  belongs_to :standup_meeting

  # enum section: {
  #   yesterday_work_description: 0,
  #   today_work_description: 1,
  #   blockers_description: 2
  # }

  has_rich_text :content
end
