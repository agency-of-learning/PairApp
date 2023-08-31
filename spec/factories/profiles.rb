# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  github_link            :string
#  job_search_status      :integer          default("not_job_searching")
#  job_title              :string
#  linked_in_link         :string
#  location               :string
#  personal_site_link     :string
#  slug                   :string
#  twitter_link           :string
#  visibility             :integer          default("private"), not null
#  work_model_preferences :enum             is an Array
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
#
# Indexes
#
#  index_profiles_on_slug     (slug) UNIQUE
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
    slug { user.full_name.parameterize }
    visibility { Profile.visibilities[:public] }

    trait :with_links do
      github_link { Faker::Internet.url(host: 'github.com') }
      linked_in_link { Faker::Internet.url(host: 'linkedin.com/in') }
      personal_site_link { Faker::Internet.url }
      twitter_link { Faker::Internet.url(host: 'twitter.com') }
    end

    transient do
      picture { nil }
    end

    after(:build) do |profile, evaluator|
      next unless evaluator.picture

      profile.picture.attach(
        io: Rails.root.join('spec/fixtures/test_image.png').open,
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
