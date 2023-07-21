# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  bio        :text
#  job_title  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :profile do
    user { nil }
    bio { "MyText" }
    job_title { "MyString" }
  end
end
