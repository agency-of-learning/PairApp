# == Schema Information
#
# Table name: standup_meeting_groups_users
#
#  id                       :bigint           not null, primary key
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  standup_meeting_group_id :bigint           not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_smg_users_on_smg_id_and_user_id  (standup_meeting_group_id,user_id)
#  index_smg_users_on_user_id_and_smg_id  (user_id,standup_meeting_group_id)
#
class StandupMeetingGroupUser < ApplicationRecord
  self.table_name = 'standup_meeting_groups_users'

  belongs_to :standup_meeting_group
  belongs_to :user

  validates :user_id,
    uniqueness: {
      scope: :standup_meeting_group_id,
      message: 'already a member of the standup group'
    }
end
