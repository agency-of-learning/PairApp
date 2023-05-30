# == Schema Information
#
# Table name: standup_meetings
#
#  id                         :bigint           not null, primary key
#  blockers_description       :text             not null
#  meeting_date               :date             not null
#  status                     :integer          default("attended"), not null
#  today_work_description     :text             not null
#  yesterday_work_description :text             not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  standup_meeting_group_id   :bigint           not null
#  user_id                    :bigint           not null
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
  belongs_to :standup_meeting_group, inverse_of: :standup_meetings
  belongs_to :user

  enum status: {
    attended: 0,
    skipped: 1
  }
end
