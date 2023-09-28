require 'rails_helper'

RSpec.describe StandupMeetingMailer do
  let(:standup_meeting) { create(:standup_meeting) }
  let(:recipient) { standup_meeting.user }

  describe '#notify_member_of_daily_meeting' do
    subject(:mail) { described_class.with(recipient:, standup_meeting:).notify_member_of_daily_meeting }

    it 'renders the headers' do
      expect(mail.subject).to eq("#{standup_meeting.group.name} - Standup Meeting Reminder")
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['no_reply@agencyoflearning.com'])
    end
  end
end
