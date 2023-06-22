require 'rails_helper'
RSpec.describe PairRequest::RejectionPolicy do
  subject { described_class }

  let(:author) { build(:user) }
  let(:invitee) { build(:user) }
  let(:pending_pair_request) { build(:pair_request, author:, invitee:) }

  permissions :create? do
    context 'the user is not the invitee' do
      it 'denies access, regardless of request status' do
        expect(subject).not_to permit(author, pending_pair_request)
      end
    end

    context 'the user is the invitee' do
      it 'grants access if the request is pending' do
        expect(subject).to permit(invitee, pending_pair_request)
      end

      it 'grants access if the request is accepted' do
        accepted_pair_request = build(:pair_request, status: :accepted, invitee:)
        expect(subject).to permit(invitee, accepted_pair_request)
      end

      it 'denies access if the request is rejected' do
        rejected_pair_request = build(:pair_request, status: :rejected, invitee:)
        expect(subject).not_to permit(invitee, rejected_pair_request)
      end

      it 'denies access if the request is expired' do
        expired_pair_request = build(:pair_request, status: :expired, invitee:)
        expect(subject).not_to permit(invitee, expired_pair_request)
      end

      it 'denies access if the request is completed' do
        completed_pair_request = build(:pair_request, status: :completed, invitee:)
        expect(subject).not_to permit(invitee, completed_pair_request)
      end

      it 'denies access if the request is cancelled' do
        cancelled_pair_request = build(:pair_request, status: :cancelled, invitee:)
        expect(subject).not_to permit(invitee, cancelled_pair_request)
      end
    end
  end
end
