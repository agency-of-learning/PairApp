# == Schema Information
#
# Table name: standup_meetings
#
#  id                       :bigint           not null, primary key
#  meeting_date             :date             not null
#  status                   :integer          default("draft"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  standup_meeting_group_id :bigint           not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_standup_meetings_on_standup_meeting_group_id  (standup_meeting_group_id)
#  index_standup_meetings_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (standup_meeting_group_id => standup_meeting_groups.id)
#  fk_rails_...  (user_id => users.id)
#
class StandupMeeting < ApplicationRecord
  has_noticed_notifications

  belongs_to :standup_meeting_group, inverse_of: :standup_meetings
  belongs_to :user

  has_rich_text :yesterday_work_description
  has_rich_text :today_work_description
  has_rich_text :blockers_description

  alias_method :group, :standup_meeting_group

  validates :meeting_date, presence: true

  enum status: {
    draft: 0,
    completed: 1,
    skipped: 2,
    missed: 3
  }

  scope :for_member, ->(user, group) { where(user:, standup_meeting_group: group) }
end
