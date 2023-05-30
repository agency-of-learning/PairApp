# == Schema Information
#
# Table name: standup_meeting_groups
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  frequency  :integer          default("daily"), not null
#  name       :string           not null
#  start_time :time             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :standup_meeting_group do
    name { Faker::Lorem.word }
    active { true }
    frequency { :daily }
    start_time { Time.zone.parse('9:00') }

    trait :inactive do
      active { false }
    end
  end
end
