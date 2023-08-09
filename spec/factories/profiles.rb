# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  job_search_status      :integer          default("not_job_searching")
#  job_title              :string
#  location               :string
#  work_model_preferences :enum             is an Array
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
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
    user
    bio { Faker::Lorem.paragraph }
    job_title { Faker::Job.title }
    location { Faker::Address.country }
    job_search_status { Profile.job_search_statuses[:not_job_searching] }
    work_model_preferences { ['remote'] }

    transient do
      attached_picture { false }
    end

    after(:build) do |profile, evaluator|
      next unless evaluator.attached_picture

      profile.picture.attach(
        io: Rails.root.join('spec/fixtures/test_image.png').open,
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
