require 'rails_helper'

RSpec.describe UserMenteeApplicationPolicy, type: :policy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:random_user) { build(:user) }
  let(:admin) { build(:user, :admin) }
  let(:moderator) { build(:user, :moderator) }

  permissions :show? do
    let!(:user_mentee_application) { create(:user_mentee_application, user:) }

    it 'allows access to admin' do
      expect(subject).to permit(admin, user_mentee_application)
    end

    it 'allows access to moderators' do
      expect(subject).to permit(moderator, user_mentee_application)
    end

    it 'allows access to matching user' do
      expect(subject).to permit(user, user_mentee_application)
    end

    it 'denies access to non-matching user' do
      expect(subject).not_to permit(random_user, user_mentee_application)
    end
  end

  permissions :new?, :create? do
    let!(:user_mentee_application) { create(:user_mentee_application, user:) }

    it 'allows access to a user' do
      expect(subject).to permit(user, user_mentee_application)
    end
  end

  permissions :edit?, :update? do
    let!(:user_mentee_application) { create(:user_mentee_application, user:) }

    it 'denies access if user is not owner' do
      expect(subject).not_to permit(random_user, user_mentee_application)
    end

    it 'grants access if user is owner' do
      expect(subject).to permit(user, user_mentee_application)
    end
  end
end
