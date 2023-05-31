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
  belongs_to :author, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :referenceable, polymorphic: true

  enum status: {
    draft: 0,
    completed: 1
  }

  DATA_OBJECT = {
    "feedback"=>[
      {
        "type"=>"long_text",
        "answer"=>"", "question"=>"Question 1", 
        "required"=>true
      },
      {
        "type"=>"long_text",
        "answer"=>"",
        "question"=>"Question 2",
        "required"=>true
      },
      {
        "type"=>"long_text", 
        "answer"=>"", 
        "question"=>"Question 3", 
        "required"=>true
      }
    ]}.freeze

  def self.create_feedback_records(pair_request)
    # The two lines below need to be kept in this order. The second line creates the feedback record for the author and that's what we want to return.
    Feedback.create(author_id: pair_request.invitee_id, receiver_id: pair_request.author_id, referenceable: pair_request, data: DATA_OBJECT )
    Feedback.create(author_id: pair_request.author_id, receiver_id: pair_request.invitee_id, referenceable: pair_request, data: DATA_OBJECT )
  end
end