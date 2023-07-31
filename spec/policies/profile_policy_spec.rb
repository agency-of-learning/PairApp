require 'rails_helper'

RSpec.describe ProfilePolicy, type: :policy do
  subject { described_class }

  let(:profile) { build(:profile, user: user_with_profile) }
  let(:user_with_profile) { build(:user) }
  let(:random_user) { build(:user) }

  permissions :show? do
    it 'grants access to everyone' do
      expect(subject).to permit(random_user, profile)
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
