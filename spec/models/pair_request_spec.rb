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

require 'rails_helper'

RSpec.describe PairRequest do
  subject { build(:pair_request, duration:, when: when_date) }

  let(:duration) { 20.minutes }
  let(:when_date) { Date.current + 2.weeks }

  describe '#versioning' do
    # NOTE: this is a helper method provided by the paper_trail gem
    with_versioning do
      before do
        subject.save!
      end

      it 'enables paper_trail' do
        expect(subject).to be_versioned
      end

      context 'when created' do
        it 'creates a version' do
          expect(subject.versions.count).to eq(1)
        end

        it 'creates a version with the correct event' do
          expect(subject.versions.last.event).to eq('create')
        end
      end

      context 'when updated' do
        before do
          subject.accepted!
        end

        it 'creates another version' do
          expect(subject.versions.count).to eq(2)
        end

        it 'creates a version with the correct event' do
          expect(subject.versions.last.event).to eq('update')
        end
      end

      context 'when deleted' do
        before do
          subject.destroy
        end

        it 'creates another version' do
          expect(subject.versions.count).to eq(2)
        end

        it 'creates a version with the correct event' do
          expect(subject.versions.last.event).to eq('destroy')
        end
      end
    end
  end

  describe '#duration' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    context 'when duration is less than 5 minutes' do
      let(:duration) { 4.minutes }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end

  describe '#when' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    context 'when date is more than a month into the future' do
      let(:when_date) { Date.current + 2.months }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end

  describe '#started?' do
    context "when the request hasn't started" do
      let(:when_date) { Date.tomorrow }

      it 'returns false' do
        expect(subject).not_to be_started
      end
    end

    context "when the request has started" do
      let(:when_date) { Time.current }

      it 'returns true' do
      expect(subject).to be_started
      end
    end
  end
end
