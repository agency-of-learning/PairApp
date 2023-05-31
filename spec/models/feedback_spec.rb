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
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe '#create_feedback_records' do
    let(:pair_request) { create(:pair_request) }

    it 'creates two feedback records' do
      expect {
        Feedback.create_feedback_records(pair_request)
      }.to change(Feedback, :count).by(2)
    end

    it 'associates the feedback with the pair request' do
      feedback = Feedback.create_feedback_records(pair_request)
      expect(feedback.referenceable).to eq(pair_request)
    end
  end
end



