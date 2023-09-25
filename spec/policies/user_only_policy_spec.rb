require 'rails_helper'

RSpec.describe UserOnlyPolicy, type: :policy do
  subject { described_class }

  let(:member_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let(:applicant_user) { create(:user, :applicant) }
  let(:moderator_user) { create(:user, :moderator) }

  permissions :admin? do
    it 'denies access if user is not admin' do
      expect(subject).not_to permit(member_user)
      expect(subject).not_to permit(applicant_user)
    end

    it 'grants access if user is admin' do
      expect(subject).to permit(admin_user)
    end
  end

  permissions :application_reviewer? do
    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin_user)
    end

    it 'grants access if the user is a moderator' do
      expect(subject).to permit(moderator_user)
    end

    it 'denies access if user is a member' do
      expect(subject).not_to permit(member_user)
    end

    it 'denies access if user is an applicant' do
      expect(subject).not_to permit(applicant_user)
    end
  end
end
