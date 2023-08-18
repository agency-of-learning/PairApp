# == Schema Information
#
# Table name: resumes
#
#  id         :bigint           not null, primary key
#  current    :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_resumes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :resume do
    user
    name { 'My Resume' }
    current { true }
    resume { nil }
  end
end
