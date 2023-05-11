require 'rails_helper'
RSpec.describe PairRequest::RejectionPolicy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:author) { build(:user) }
  let(:invitee) { build(:user) }
  let(:pending_pair_request) { build(:pair_request, author: author, invitee: invitee) }
  let(:accepted_pair_request) { build(:pair_request, status: :accepted, author: author, invitee: invitee) }
  let(:rejected_pair_request) { build(:pair_request, status: :rejected, author: author, invitee: invitee) }
  let(:expired_pair_request) { build(:pair_request, status: :expired, author: author, invitee: invitee) }

  permissions :create? do
    it 'grants access if the user is the author' do
      expect(subject).to permit(author, build(:pair_request, author: author))
    end

    it 'grants access if the user is the invitee' do
      expect(subject).to permit(invitee, build(:pair_request, invitee: invitee))
    end

    it 'denies access if the user is not the author or invitee' do
      expect(subject).not_to permit(user, build(:pair_request, author: author, invitee: invitee))
    end

    it 'denies access if the pair_request is rejected' do
      expect(subject).not_to permit(author, rejected_pair_request)
    end

    it 'denies access if the pair request is expired' do 
      expect(subject).not_to permit(author, expired_pair_request)
    end
  end
end