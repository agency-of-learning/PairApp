# == Schema Information
#
# Table name: pair_requests
#
#  id         :bigint           not null, primary key
#  duration   :float            not null
#  status     :integer          default(0), not null
#  when       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer          not null
#  invitee_id :integer          not null
#
FactoryBot.define do
  factory :pair_request do
    association :author, factory: :user
    association :invitee, factory: :user
    duration { 900.0 }
    add_attribute(:when) { DateTime.now }
  end
end
