# == Schema Information
#
# Table name: mentee_application_states
#
#  id                         :bigint           not null, primary key
#  note                       :text
#  slug                       :string
#  status                     :integer          default("application_received"), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  status_changed_id          :bigint
#  user_mentee_application_id :bigint           not null
#
# Indexes
#
#  index_mentee_application_states_on_status_changed_id           (status_changed_id)
#  index_mentee_application_states_on_user_mentee_application_id  (user_mentee_application_id)
#  index_on_slug_and_user_mentee_application_id                   (slug,user_mentee_application_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (status_changed_id => users.id)
#  fk_rails_...  (user_mentee_application_id => user_mentee_applications.id)
#
FactoryBot.define do
  factory :mentee_application_state do
    user_mentee_application
    status { 0 }
    note { 'MyText' }
    slug { status }

    trait :application_received do
      status { :application_received }
    end
    trait :coding_challenge_sent do
      status { :coding_challenge_sent }
    end
    trait :coding_challenge_received do
      status { :coding_challenge_received }
    end
    trait :coding_challenge_approved do
      status { :coding_challenge_approved }
    end
    trait :phone_screen_scheduled do
      status { :phone_screen_scheduled }
    end
    trait :phone_screen_completed do
      status { :phone_screen_completed }
    end
    trait :accepted do
      status { :accepted }
    end
    trait :rejected do
      status { :rejected }
    end
  end
end
