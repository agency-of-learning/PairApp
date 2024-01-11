# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetingGroups::JoinPolicy, type: :policy do
  subject { described_class }

  let(:standup_meeting_group_user) { build(:standup_meeting_group_user) }

  permissions :create? do
    it 'always grants access' do
      expect(subject).to permit(
        standup_meeting_group_user.user,
        standup_meeting_group_user
      )
    end
  end

  permissions :destroy? do
    context 'when the user is an admin' do
      it 'grants access' do
        admin = build(:user, :admin)
        expect(subject).to permit(admin, standup_meeting_group_user)
      end
    end

    context 'when the user is not an admin' do
      context 'when the user is the standup meeting group user' do
        it 'grants access' do
          expect(subject).to permit(
            standup_meeting_group_user.user,
            standup_meeting_group_user
          )
        end
      end

      context 'when the user is not the standup meeting group user' do
        it 'denies access' do
          wrong_user = build(:user)
          expect(subject).not_to permit(wrong_user, standup_meeting_group_user)
        end
      end
    end
  end
end
