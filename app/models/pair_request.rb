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
class PairRequest < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  validates :when,
    presence: true,
    inclusion: { in: (Date.current..(Date.current + 1.month)) }
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 5.minutes }
  validates :status, presence: true

  enum status: {
    pending: 0,
    rejected: 1,
    accepted: 2,
    expired: 3
  }
end
