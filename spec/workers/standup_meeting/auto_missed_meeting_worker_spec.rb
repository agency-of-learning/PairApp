require 'rails_helper'

RSpec.describe StandupMeetings::AutoMissedMeetingWorker do
  context 'when the meeting is a draft meeting' do
    let!(:new_draft_meeting) { create(:standup_meeting) }
    let!(:old_draft_meeting) { create(:standup_meeting, meeting_date: 8.days.ago) }

    before do
      described_class.new.perform
    end

    it 'does not change the status for new draft meetings' do
      new_draft_meeting.reload
      expect(new_draft_meeting.status).to eq 'draft'
    end

    it "changes the status to 'missed' for old draft meetings" do
      old_draft_meeting.reload
      expect(old_draft_meeting.status).to eq 'missed'
    end
  end

  context 'when the meeting is not a draft meeting' do
    let!(:old_completed_meeting) { create(:standup_meeting, meeting_date: 8.days.ago, status: :completed) }
    let!(:old_skipped_meeting) { create(:standup_meeting, meeting_date: 8.days.ago, status: :skipped) }

    before do
      described_class.new.perform
    end

    it 'does not change the status for old completed meetings' do
      old_completed_meeting.reload
      expect(old_completed_meeting.status).to eq 'completed'
    end

    it 'does not change the status for old skipped meetings' do
      old_skipped_meeting.reload
      expect(old_skipped_meeting.status).to eq 'skipped'
    end
  end
end
