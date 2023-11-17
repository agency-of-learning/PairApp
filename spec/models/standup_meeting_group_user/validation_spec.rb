require 'rails_helper'

RSpec.describe StandupMeetingGroupUser do
  describe 'uniqueness validation' do
    context 'when a user has not joined a standup meeting group' do
      let!(:user) { create(:user) }
      let!(:standup_meeting_group) { create(:standup_meeting_group) }

      it 'allows the user to join' do
        smgu = described_class.new(user:, standup_meeting_group:)

        expect(smgu).to be_valid
      end

      context 'when a user has already joined a different standup meeting group' do
        it 'allows the user to join' do
          described_class.create(user:,
            standup_meeting_group: create(:standup_meeting_group))
          smgu = described_class.new(user:, standup_meeting_group:)

          expect(smgu).to be_valid
        end
      end

      context 'when a second user has already joined the standup meeting group' do
        it 'allows the first user to join' do
          described_class.create(user: create(:user), standup_meeting_group:)
          smgu = described_class.new(user:, standup_meeting_group:)

          expect(smgu).to be_valid
        end
      end
    end

    context 'when a user has already joined a standup meeting group' do
      it 'does not allow the user to join' do
        smgu = described_class.create(user: create(:user),
          standup_meeting_group: create(:standup_meeting_group))
        duplicate_smgu = described_class.new(user: smgu.user,
          standup_meeting_group: smgu.standup_meeting_group)

        expect(duplicate_smgu).not_to be_valid
      end
    end
  end
end
