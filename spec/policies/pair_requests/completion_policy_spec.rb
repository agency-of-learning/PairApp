require 'rails_helper'
RSpec.describe PairRequests::CompletionPolicy do
  subject { described_class }

  let(:author) { build(:user) }
  let(:invitee) { build(:user) }
  let(:future_pair_request) do
    build(:pair_request, author:, status: :accepted, when: Date.tomorrow)
  end
  let(:pending_pair_request) { build(:pair_request, author:, when: Date.yesterday) }
  let(:started_pair_request) do
    build(:pair_request, author:, invitee:, status: :accepted, when: Date.yesterday)
  end

  permissions :create? do
    context 'when the user is the author' do
      it 'grants permission if the request is accepted and in the past' do
        expect(subject).to permit(author, started_pair_request)
      end

      it 'denies permission when the request is not accepted' do
        expect(subject).not_to permit(author, pending_pair_request)
      end

      it 'denies permission when the request is in the future' do
        expect(subject).not_to permit(author, future_pair_request)
      end
    end

    context 'when the user is the invitee' do
      it 'denies permission' do
        expect(subject).not_to permit(invitee, started_pair_request)
      end
    end
  end
end
