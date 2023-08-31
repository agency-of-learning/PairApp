require 'rails_helper'

RSpec.describe Profiles::VisibilityTogglePolicy do
  subject { described_class }

  let(:profile) { create(:profile) }
  let(:owning_user) { profile.user }
  let(:random_user) { build(:user) }

  permissions :create? do
    it 'grants access when the profile belongs to the user' do
      expect(subject).to permit(owning_user, profile)
    end

    it 'denies access when the profile does not belong to the user' do
      expect(subject).not_to permit(random_user, profile)
    end
  end
end
