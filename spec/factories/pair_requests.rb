FactoryBot.define do
  factory :pair_request do
    association :author, factory: :user
    association :acceptor, factory: :user
    duration { 1.5 }
    add_attribute(:when) { DateTime.now }
  end
end
