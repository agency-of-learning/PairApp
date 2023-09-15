require 'rails_helper'

RSpec.describe StandupMeetingGroup::DetermineMissingStandupMeetingsWorker do
  let(:current_date) { Date.parse('2020-01-01') }

  before do
    allow(Date).to receive(:current).and_return(current_date)
  end

  describe '#perform' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:active) { true }
    let(:standup_meeting_group) { create(:standup_meeting_group, start_time: 30.minutes.from_now, active:) }

    context 'when all standup_meeting_groups have standup_meetings' do
      before do
        create(:standup_meeting_group_user, user:, standup_meeting_group:)
        create(:standup_meeting, user:, standup_meeting_group:, meeting_date: current_date)
      end

      it 'does not create any additional jobs (fanout)' do
        expect(StandupMeeting::CreateDraftWorker).not_to receive(:perform_async)

        described_class.new.perform(0, 60)
      end
    end

    context 'when the current day is on a weekend' do
      let(:current_date) { Date.parse('2020-01-01').sunday }

      before do
        create(:standup_meeting_group_user, user:, standup_meeting_group:)
      end

      it 'does not create any additional jobs' do
        expect(StandupMeeting::CreateDraftWorker).not_to receive(:perform_async)

        described_class.new.perform(0, 60)
      end
    end

    context 'when a standup_meeting_group does not have standup_meetings and is within timeframe' do
      before do
        create(:standup_meeting_group_user, user:, standup_meeting_group:)
      end

      it 'creates a job for that standup_meeting_group' do
        expect(StandupMeeting::CreateDraftWorker).to receive(:perform_async).with(
          standup_meeting_group.id, user.id, current_date.to_s
        )

        described_class.new.perform(0, 60)
      end

      context 'when the standup_meeting_group has some standup_meetings but not all' do
        before do
          create(:standup_meeting_group_user, user: other_user, standup_meeting_group:)
          create(:standup_meeting, user:, standup_meeting_group:, meeting_date: current_date)
        end

        it 'creates a job for that standup_meeting_group' do
          expect(StandupMeeting::CreateDraftWorker).to receive(:perform_async).with(
            standup_meeting_group.id, user.id, current_date.to_s
          )

          expect(StandupMeeting::CreateDraftWorker).to receive(:perform_async).with(
            standup_meeting_group.id, other_user.id, current_date.to_s
          )

          described_class.new.perform(0, 60)
        end
      end

      context 'when the standup_meeting_group is inactive' do
        let(:active) { false }

        it 'does not create any additional jobs' do
          expect(StandupMeeting::CreateDraftWorker).not_to receive(:perform_async)

          described_class.new.perform(0, 60)
        end
      end
    end
  end
end
