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
  # NOTE: might modify this to only save for specific scenarios like when changing from
  # draft -> completed. Want to noodle on this a bit.
  has_paper_trail
  has_noticed_notifications

  belongs_to :author, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  has_many :references, as: :referenceable, dependent: :destroy, class_name: 'Feedback'

  validates :when,
    presence: true,
    inclusion: { in: (Date.current..(Date.current + 1.months)),
                 message: 'field must not be in the past or more than 1 month into the future' },
    if: -> { pending? }
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 5.minutes }
  validates :status, presence: true

  enum status: {
    pending: 0,
    rejected: 1,
    accepted: 2,
    expired: 3,
    completed: 4,
    cancelled: 5
  }
  STATUS_PRIORITIES = %i[pending accepted completed cancelled expired rejected].freeze

  scope :order_by_date, -> { order(:when) }
  scope :order_by_status, -> { in_order_of(:status, STATUS_PRIORITIES) }
  scope :upcoming, -> { where(when: Time.now..) }
  scope :past, -> { where(when: ..Time.now).order(when: :desc) }

  def started?
    self.when <= Time.current
  end

  def end_time
    self.when + duration
  end

  def create_draft_feedback!
    data = Feedback::DATA_OBJECT
    references.build([
      { author:, receiver: invitee, data: },
      { author: invitee, receiver: author, data: }
    ])

    save!
  end

  def author_feedback
    references.find_by(author:)
  end

  def invitee_feedback
    references.find_by(author: invitee)
  end

  def authored_feedback_for(user)
    references.find_by(author: user)
  end

  def partner_for(user)
    if author == user
      invitee
    elsif invitee == user
      author
    end
  end
end
