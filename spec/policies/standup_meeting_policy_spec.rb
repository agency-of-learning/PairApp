require 'rails_helper'

RSpec.describe StandupMeetingPolicy, type: :policy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:random_user) { build(:user) }
  let(:admin) { build(:user, :admin) }

  let(:standup_meeting_group) { create(:standup_meeting_group) }
  let(:user_standup_meeting) { build(:standup_meeting, user:, standup_meeting_group:) }

  before do
    create(:standup_meeting_group_user, user:, standup_meeting_group:)
  end

  permissions :index? do
    it 'denies access if user is a member of the group' do
      expect(subject).not_to permit(random_user, standup_meeting_group)
    end

    it 'grants access if user is owner' do
      expect(subject).to permit(user, standup_meeting_group)
    end

    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, standup_meeting_group)
    end
  end

  permissions :edit?, :update? do
    it 'denies access if user is not owner' do
      expect(subject).not_to permit(random_user, user_standup_meeting)
    end

    it 'grants access if user is owner' do
      expect(subject).to permit(user, user_standup_meeting)
    end
  end
end
