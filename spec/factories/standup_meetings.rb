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
FactoryBot.define do
  factory :standup_meeting do
    user
    standup_meeting_group

    yesterday_work_description { Faker::Lorem.paragraph }
    today_work_description { Faker::Lorem.paragraph }
    blockers_description { Faker::Lorem.paragraph }

    meeting_date { Date.current }
    status { StandupMeeting.statuses[:draft] }
  end
end
