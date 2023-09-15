require 'rails_helper'

RSpec.describe ProfilePolicy, type: :policy do
  subject { described_class }

  let(:profile) { create(:profile, visibility:) }
  let(:user_with_profile) { profile.user }
  let(:random_user) { build(:user) }
  let(:visibility) { :public }

  permissions :show? do
    context 'when the profile is public' do
      it 'grants access to everyone' do
        expect(subject).to permit(random_user, profile)
      end
    end

    context 'when the profile is private' do
      let(:visibility) { :private }
      let(:admin) { build(:user, :admin) }

      it 'grants access to the owning user' do
        expect(subject).to permit(user_with_profile, profile)
      end

      it 'denies access to a random user' do
        expect(subject).not_to permit(random_user, profile)
      end

      it 'grants access to an admin user' do
        expect(subject).to permit(admin, profile)
      end
    end
  end

  permissions :update? do
    it 'denies access to users that do not own the profile' do
      expect(subject).not_to permit(random_user, profile)
    end

    it 'grants access to the user that owns the profile' do
      expect(subject).to permit(user_with_profile, profile)
    end
  end
end
