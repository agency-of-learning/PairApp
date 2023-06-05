# == Schema Information
#
# Table name: pair_requests
#
#  id         :bigint           not null, primary key
#  duration   :integer          not null
#  status     :integer          default("pending"), not null
#  when       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint           not null
#  invitee_id :bigint           not null
#
# Indexes
#
#  index_pair_requests_on_author_id   (author_id)
#  index_pair_requests_on_invitee_id  (invitee_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (invitee_id => users.id)
#
FactoryBot.define do
  factory :pair_request do
    author factory: %i[user]
    invitee factory: %i[user]
    duration { 15.minutes }

    add_attribute(:when) { 1.day.from_now }
    status { PairRequest.statuses[:pending] }


    trait :completed_with_feedback do
      after(:create) do |pair_request|
        create_list(:feedback, 2, :draft, referenceable: self)
      end
    end
  end
end
