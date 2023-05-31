# == Schema Information
#
# Table name: standup_meeting_groups
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  frequency  :integer          default("daily"), not null
#  name       :string           not null
#  start_time :time             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class StandupMeetingGroup < ApplicationRecord
  has_many :standup_meetings, inverse_of: :standup_meeting_group, dependent: :destroy
  has_many :standup_meeting_groups_users, dependent: :destroy, class_name: 'StandupMeetingGroupUser'
  has_many :users, through: :standup_meeting_groups_users

  validates :name, presence: true
  validates :start_time, presence: true

  enum frequency: {
    daily: 0
  }
end
