FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    time_zone { 'PST' }
  end
end
