require 'rails_helper'

RSpec.describe InvitationPolicy do
  subject { described_class }

  let(:member) { build(:user) }
  let(:admin) { build(:user, :admin) }

  permissions :new?, :create? do
    it 'denies access to regular member users' do
      expect(subject).not_to permit(member)
    end

    it 'grants access to admin users' do
      expect(subject).to permit(admin)
    end
  end

  permissions :edit?, :update? do
    it 'grants access to member users' do
      expect(subject).to permit(member)
    end
  end
end
