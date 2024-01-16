# == Schema Information
#
# Table name: standup_meeting_comments
#
#  id                 :bigint           not null, primary key
#  section_name       :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  standup_meeting_id :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_standup_meeting_comments_on_standup_meeting_id  (standup_meeting_id)
#  index_standup_meeting_comments_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (standup_meeting_id => standup_meetings.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :standup_meeting_comment do
    name { 'MyString' }
    standup_meeting
    user
  end
end
