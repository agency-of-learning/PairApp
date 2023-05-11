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
end
