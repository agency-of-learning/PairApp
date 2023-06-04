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

RSpec.describe Feedback do
  subject { build(:feedback, locked_at:) }

  let(:locked_at) { nil }

  describe '#update_with_json_answers' do
    let(:params) do
      ActionController::Parameters.new(
        feedback: { data:, overall_rating: }
      )
    end
    let(:data) do
      {
        'feedback' => {
          '0' => { 'answer' => 'Answer0' },
          '1' => { 'answer' => 'Answer1' },
          '2' => { 'answer' => 'Answer2' }
        }
      }
    end

    context 'when the params are valid' do
      let(:overall_rating) { '50' }

      it 'saves the new overall_rating to the feedback object' do
        subject.update_with_json_answers(params)
        expect(subject.overall_rating).to eq 50
      end

      it 'sets the lock date to 7 days from now' do
        subject.update_with_json_answers(params)
        expect(subject.locked_at.to_date).to eq(7.days.from_now.to_date)
      end

      it 'has no errors' do
        subject.update_with_json_answers(params)
        expect(subject.errors).to be_empty
      end

      it 'returns true' do
        expect(subject.update_with_json_answers(params)).to be true
      end
    end

    context 'when the params are invalid' do
      let(:overall_rating) { '101' }

      it 'adds overall_rating as an error' do
        subject.update_with_json_answers(params)
        expect(subject.errors.key?(:overall_rating)).to be true
      end

      it 'returns false' do
        expect(subject.update_with_json_answers(params)).to be false
      end
    end
  end

  describe '#locked?' do
    context "when locked_at hasn't been set" do
      it 'returns false' do
        expect(subject).not_to be_locked
      end
    end

    context "when the locked_at date hasn't passed" do
      let(:locked_at) { Date.tomorrow }

      it 'returns false' do
        expect(subject).not_to be_locked
      end
    end

    context 'when the locked_at date has passed' do
      let(:locked_at) { Date.yesterday }

      it 'returns true' do
        expect(subject).to be_locked
      end
    end
  end
end
