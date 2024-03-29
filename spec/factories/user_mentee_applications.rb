# == Schema Information
#
# Table name: user_mentee_applications
#
#  id                                :bigint           not null, primary key
#  additional_information            :text
#  available_hours_per_week          :integer          not null
#  city                              :string           not null
#  country                           :string           not null
#  github_url                        :string
#  learned_to_code                   :text             not null
#  linkedin_url                      :string
#  project_experience                :text             not null
#  reason_for_applying               :text             not null
#  referral_source                   :string
#  state                             :string           not null
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  user_id                           :bigint           not null
#  user_mentee_application_cohort_id :bigint           not null
#
# Indexes
#
#  idx_user_mentee_applications_on_mentee_application_cohort_id  (user_mentee_application_cohort_id)
#  index_user_mentee_applications_on_user_id                     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (user_mentee_application_cohort_id => user_mentee_application_cohorts.id)
#
FactoryBot.define do
  factory :user_mentee_application do
    user { association :user, :applicant }
    user_mentee_application_cohort

    learned_to_code { Faker::Lorem.paragraph }
    project_experience { Faker::Lorem.paragraph }
    reason_for_applying { 'Help with job search' }

    available_hours_per_week { 10 }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }

    github_url { 'https://github.com/user' }
    linkedin_url { 'https://www.linkedin.com/in/user/' }

    trait :with_resume do
      after(:create) do |user_mentee_application|
        create(:resume, user: user_mentee_application.user, current: true)
      end
    end

    trait :application_received do
      after(:create) do |user_mentee_application|
        create(:mentee_application_state, :application_received, user_mentee_application:)
      end
    end

    trait :coding_challenge_sent do
      after(:create) do |user_mentee_application|
        create(:mentee_application_state, :coding_challenge_sent, user_mentee_application:)
      end
    end

    trait :coding_challenge_received do
      after(:create) do |user_mentee_application|
        create(:mentee_application_state, :coding_challenge_received, user_mentee_application:)
      end
    end

    trait :coding_challenge_approved do
      after(:create) do |user_mentee_application|
        create(:mentee_application_state, :coding_challenge_approved, user_mentee_application:)
      end
    end

    trait :phone_screen_scheduled do
      after(:create) do |user_mentee_application|
        create(:mentee_application_state, :phone_screen_scheduled, user_mentee_application:)
      end
    end

    trait :phone_screen_completed do
      after(:create) do |user_mentee_application|
        create(:mentee_application_state, :phone_screen_completed, user_mentee_application:)
      end
    end

    trait :accepted do
      after(:create) do |user_mentee_application|
        create(:mentee_application_state, :accepted, user_mentee_application:)
      end
    end

    trait :rejected do
      after(:create) do |user_mentee_application|
        create(:mentee_application_state, :rejected, user_mentee_application:)
      end
    end

    trait :withdrawn do
      after(:create) do |user_mentee_application|
        create(:mentee_application_state, :rejected, user_mentee_application:)
      end
    end
  end
end
