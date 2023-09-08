# == Schema Information
#
# Table name: user_mentee_application_cohorts
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE), not null
#  active_date_range :daterange        not null
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :user_mentee_application_cohort do
    name { Faker::Lorem.word }
    active_date_range { Date.current..2.months.from_now }
    active { true }
  end
end
