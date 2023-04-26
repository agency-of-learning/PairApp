# == Schema Information
#
# Table name: pair_requests
#
#  id          :bigint           not null, primary key
#  duration    :float
#  when        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  acceptor_id :integer
#  author_id   :integer
#
FactoryBot.define do
  factory :pair_request do
    association :author, factory: :user
    association :acceptor, factory: :user
    duration { 1.5 }
    add_attribute(:when) { DateTime.now }
  end
end
