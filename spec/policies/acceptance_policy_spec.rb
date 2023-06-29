require 'rails_helper'
RSpec.describe PairRequest::AcceptancePolicy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:invitee) { build(:user) }
  let(:pending_pair_request) { build(:pair_request, invitee:) }
  let(:expired_pair_request) { build(:pair_request, status: :expired, invitee:) }
  let(:accepted_pair_request) { build(:pair_request, status: :accepted, invitee:) }
  let(:cancelled_pair_request) { build(:pair_request, status: :cancelled, invitee:) }

  permissions :create? do
    context 'when user is the invitee' do
      it 'grants access if the request is pending' do
        expect(subject).to permit(invitee, pending_pair_request)
      end

      it 'denies access if the request is expired' do
        expect(subject).not_to permit(invitee, expired_pair_request)
      end

      it 'denies access if the request is cancelled' do
        expect(subject).not_to permit(invitee, cancelled_pair_request)
      end
    end

    it 'denies access if the user is not the invitee' do
      expect(subject).not_to permit(user, pending_pair_request)
    end
  end
end
