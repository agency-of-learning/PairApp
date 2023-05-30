class StandupMeetingGroupUser < ApplicationRecord
  self.table_name = 'standup_meeting_groups_users'

  belongs_to :standup_meeting_group
  belongs_to :user
end
