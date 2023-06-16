# == Schema Information
#
# Table name: pair_requests
#
#  id         :bigint           not null, primary key
#  duration   :integer          not null
#  status     :integer          default("pending"), not null
#  when       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null author_id  :bigint           not null
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

  describe '#scopes' do
    describe '.order_by_status' do
      before do
        create_list(:pair_request, 5) do |request, i|
          request.status = described_class.statuses.keys[i]
          request.save!
        end
      end

      it 'has the pending request in the first position' do
        expect(described_class.order_by_status.first).to be_pending
      end

      it 'has the accepted request in the second position' do
        expect(described_class.order_by_status.second).to be_accepted
      end

      it 'has the completed request in the third position' do
        expect(described_class.order_by_status.third).to be_completed
      end

      it 'has the expired request in the fourth position' do
        expect(described_class.order_by_status.fourth).to be_expired
      end

      it 'has the rejected request in the fifth position' do
        expect(described_class.order_by_status.fifth).to be_rejected
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

    context 'when the request has started' do
      let(:when_date) { Time.current }

      it 'returns true' do
        expect(subject).to be_started
      end
    end
  end

  describe '#create_draft_feedback!' do
    it 'creates two feedback records' do
      expect { subject.create_draft_feedback! }
        .to change(Feedback, :count).by(2)
    end

    it 'creates a feedback record with the pair request author as the author' do
      subject.create_draft_feedback!
      expect(Feedback.exists?(author: subject.author)).to be true
    end

    it 'creates a feedback record with the pair request invitee as the author' do
      subject.create_draft_feedback!
      expect(Feedback.exists?(author: subject.invitee)).to be true
    end
  end

  describe '#author_feedback' do
    context 'when a feedback exists where the author is the pair request author' do
      let!(:feedback) { create(:feedback, author: subject.author, referenceable: subject) }

      it 'returns the feedback' do
        expect(subject.author_feedback).to eq feedback
      end
    end

    context 'when a feedback does not exist where the author is the pair request author' do
      it 'returns nil' do
        expect(subject.author_feedback).to be_nil
      end
    end
  end

  describe '#authored_feedback_for' do
    context 'when called with the author user and a feedback exists' do
      let!(:feedback) { create(:feedback, author: subject.author, referenceable: subject) }

      it 'returns the feedback' do
        expect(subject.authored_feedback_for(subject.author)).to eq feedback
      end
    end

    context 'when called with the invitee user and a feedback exists' do
      let!(:feedback) { create(:feedback, author: subject.invitee, referenceable: subject) }

      it 'returns the feedback' do
        expect(subject.authored_feedback_for(subject.invitee)).to eq feedback
      end
    end

    context 'when a feedback does not exist for the user' do
      it 'returns nil' do
        expect(subject.authored_feedback_for(subject.invitee)).to be_nil
      end
    end

    context 'when the user is neither the author or the invitee' do
      let(:random_user) { build(:user) }

      before do
        create(:feedback, referenceable: subject)
      end

      it 'returns nil' do
        expect(subject.authored_feedback_for(random_user)).to be_nil
      end
    end
  end

  describe '#partner_for' do
    let(:pair_request) { build(:pair_request, author:, invitee:) }
    let(:author) { build(:user) }
    let(:invitee) { build(:user) }
    let(:random_user) { build(:user) }

    context 'when method is passed the authoring user' do
      it 'returns the invitee' do
        expect(pair_request.partner_for(author)).to eq invitee
      end
    end

    context 'when the method is passed the invitee user' do
      it 'returns the author' do
        expect(pair_request.partner_for(invitee)).to eq author
      end
    end

    context 'when the method is passed a user that does not own the request' do
      it 'returns nil' do
        expect(pair_request.partner_for(random_user)).to be_nil
      end
    end
  end
end
