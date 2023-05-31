require 'rails_helper'

RSpec.describe StandupMeetingGroupPolicy, type: :policy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:random_user) { build(:user) }
  let(:admin) { build(:user, :admin) }

  let(:standup_meeting_group) { create(:standup_meeting_group) }

  before do
    create(:standup_meeting_group_user, user:, standup_meeting_group:)
  end

  permissions :index?, :create?, :update?, :destroy? do
    it 'denies access if the user is not an admin' do
      expect(subject).not_to permit(user, standup_meeting_group)
    end

    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, standup_meeting_group)
    end
  end

  permissions :show? do
    it 'denies access if the user is not a member of the standup meeting group' do
      expect(subject).not_to permit(random_user, standup_meeting_group)
    end

    it 'grants access if the user is a member of the standup meeting group' do
      expect(subject).to permit(user, standup_meeting_group)
    end

    it 'grants access if the user is an admin' do
      expect(subject).to permit(admin, standup_meeting_group)
    end
  end
end
