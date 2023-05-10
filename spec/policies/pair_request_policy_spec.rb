require 'rails_helper'
RSpec.describe PairRequestPolicy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:admin) { build(:user, :admin) }

  let(:not_owned_request) { build(:pair_request) }
  let(:authored_request) { build(:pair_request, author: user) }
  let(:invited_request) { build(:pair_request, invitee: user) }
  let(:invited_expired_request) { build(:pair_request, invitee: user, status: :expired) }

  permissions :index?, :show? do
   
    it 'denies access if the user is not the author, invitee, or an admin account' do
      binding.b
      expect(subject).not_to permit(user, not_owned_request)
    end

    it 'grants access if the user is the author' do
      expect(subject).to permit(user, authored_request)
    end

    it 'grants access if the user is the invitee' do
      expect(subject).to permit(user, invited_request)
    end

    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, not_owned_request)
    end
  end

  permissions :new?, :create? do
    it 'grants access to the user' do
      expect(subject).to permit(user, not_owned_request)
    end
  end

  permissions :accept? do
    context 'when the user is not the invitee' do
      it 'denies access' do
        expect(subject).not_to permit(user, authored_request)
      end
    end

    context 'when the user is the invitee' do
      it 'denies access if the request is expired/rejected' do
        expect(subject).not_to permit(user, invited_expired_request)
      end

      it 'grants access if the user is the invitee and the request is pending' do
        expect(subject).to permit(user, invited_request)
      end
    end
  end

  permissions :reject? do
    context 'when the user is an the owner' do
      it 'denies access' do
        expect(subject).not_to permit(user, not_owned_request)
      end
    end

    context 'when the user is an owner' do
      it "denies access if the request isn't accepted or pending" do
        expect(subject).not_to permit(user, invited_expired_request)
      end

      it 'grants access if the request is pending/accepted' do
        expect(subject).to permit(user, authored_request)
      end
    end
  end
end
