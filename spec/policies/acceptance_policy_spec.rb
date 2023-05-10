require 'rails_helper'
RSpec.describe AcceptancePolicy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:invitee) { build(:user) }
  let(:pending_pair_request) { build(:pair_request, invitee: invitee) }
  let(:expired_pair_request) { build(:pair_request, status: :expired, invitee:)}


  permissions :create? do
    it 'grants access if the user is the invitee' do
      expect(subject).to permit(invitee, pending_pair_request)
    end

    it 'denies access if the user is not the invitee' do
      expect(subject).not_to permit(user, pending_pair_request)
    end

    it 'denies access if pair_request is expired' do
      expect(subject).not_to permit(invitee, expired_pair_request)
    end

    it 'grants access if user is the invitee and request is pending' do
      expect(subject).to permit(invitee, pending_pair_request)
    end
  end
end
