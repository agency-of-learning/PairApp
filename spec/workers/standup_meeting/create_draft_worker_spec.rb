require 'rails_helper'

RSpec.describe StandupMeetings::CreateDraftWorker do
  let(:current_date) { Date.parse('2020-01-01') }

  describe '#perform' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:standup_meeting_group) { create(:standup_meeting_group, start_time: 30.minutes.from_now) }

    it 'creates a standup_meeting for the user if one does not exist and sends a notification' do
      expect {
        described_class.new.perform(standup_meeting_group.id, user.id,
          current_date.to_s)
      }.to change(StandupMeeting, :count).by(1)
    end

    context 'when a standup_meeting already exists for the user' do
      before do
        create(:standup_meeting, user:, standup_meeting_group:, meeting_date: current_date)
      end

      it 'does not create a standup_meeting for the user and does not send a notification' do
        expect {
          described_class.new.perform(standup_meeting_group.id, user.id,
            current_date.to_s)
        }.not_to change(StandupMeeting, :count)
      end
    end
  end
end
