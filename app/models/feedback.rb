# == Schema Information
#
# Table name: feedbacks
#
#  id                 :bigint           not null, primary key
#  data               :jsonb            not null
#  locked_at          :datetime
#  overall_rating     :integer          default(0), not null
#  referenceable_type :string           not null
#  status             :integer          default("draft"), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  author_id          :bigint           not null
#  receiver_id        :bigint           not null
#  referenceable_id   :bigint           not null
#
# Indexes
#
#  index_feedbacks_on_author_id      (author_id)
#  index_feedbacks_on_receiver_id    (receiver_id)
#  index_feedbacks_on_referenceable  (referenceable_type,referenceable_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (receiver_id => users.id)
#
class Feedback < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :referenceable, polymorphic: true

  enum status: {
    draft: 0,
    completed: 1
  }

  validates :overall_rating, inclusion: { in: 0..100, message: 'must be in range 0-100' }

  # rubocop:disable Layout/LineLength
  DATA_OBJECT = {
    feedback: [
      {
        slug: 'strengths',
        type: 'long_text',
        answer: '',
        question: 'What did they do really well at? (i.e: explaining the problem, breaking down problem, clean code, etc…)',
        required: true
      },
      {
        slug: 'improvements',
        type: 'long_text',
        answer: '',
        question: 'Was there anything they could improve on? (like learning new concepts, design patterns, books, etc..)',
        required: true
      },
      {
        slug: 'experiences',
        type: 'long_text',
        answer: '',
        question: 'How was your overall experience pairing with this person?',
        required: true
      },
      {
        slug: 'additional_notes',
        type: 'long_text',
        answer: '',
        question: 'Any additional notes/comments you’d like to leave?',
        required: false
      }
    ]
  }.freeze
  # rubocop:enable Layout/LineLength

  def update_with_json_answers(params)
    merged_answers = []
    DATA_OBJECT[:feedback].each_with_index do |question, index|
      answer = params.dig('feedback', 'data', 'feedback', index.to_s, 'answer') || ''
      merged_answers << question.merge('answer' => answer)
    end

    self.data = { feedback: merged_answers }
    self.overall_rating = params.dig(:feedback, :overall_rating) || 0
    self.locked_at ||= 7.days.from_now
    self.status = :completed
    save
  end

  def locked?
    return false if locked_at.blank?

    Time.current.after?(locked_at)
  end
end