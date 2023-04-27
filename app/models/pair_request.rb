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
class PairRequest < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :invitee, class_name: "User"

  validates :when,
            presence: true,
            inclusion: { in: (Date.today..(Date.today + 1.month)) }
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 900.0 }
  validates :status, presence: true

  enum status: {
    pending: 0,
    rejected: 1,
    accepted: 2,
    expired: 3
  }
end
