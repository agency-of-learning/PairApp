# == Schema Information
#
# Table name: standup_meeting_groups_users
#
#  id                       :bigint           not null, primary key
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  standup_meeting_group_id :bigint           not null
#  user_id                  :bigint           not null
#
# Indexes
#
#  index_smg_users_on_smg_id_and_user_id  (standup_meeting_group_id,user_id) UNIQUE
#  index_smg_users_on_user_id_and_smg_id  (user_id,standup_meeting_group_id) UNIQUE
#
require 'rails_helper'

RSpec.describe StandupMeetingGroupUser do
  context 'when a user has already join a standup meeting group' do
    let!(:user) { create(:user) }
    let!(:standup_meeting_group) { create(:standup_meeting_group) }

    before do
      described_class.create(user:, standup_meeting_group:)
    end

    it 'does not allow the user to join the same standup meeting group again' do
      expect {
        described_class.create(user:, standup_meeting_group:)
      }.not_to change(StandupMeetingGroupUser, :count)
    end

    it 'allows the user to join a different standup meeting group' do
      another_standup_meeting_group = create(:standup_meeting_group)

      expect {
        described_class.create(
          user:,
          standup_meeting_group: another_standup_meeting_group
        )
      }.to change(described_class, :count).by 1
    end
  end
end
