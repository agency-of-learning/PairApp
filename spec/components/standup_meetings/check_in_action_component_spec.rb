# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetings::CheckInActionComponent, type: :component do
  let(:user) { create(:user) }
  let(:standup_meeting_group) { create(:standup_meeting_group) }
  let(:standup_meeting) { create(:standup_meeting, status:, user:) }

  context 'when the standup meeting is a draft' do
    let(:status) { :draft }

    it 'renders a Check-In link' do
      render_inline(described_class.new(standup_meeting_group:, standup_meeting:, current_user: user))

      expect(page).to have_link('Check in')
    end
  end

  context 'when the standup meeting is completed' do
    let(:status) { :completed }

    it 'renders an Edit link' do
      render_inline(described_class.new(standup_meeting_group:, standup_meeting:, current_user: user))

      expect(page).to have_link('Edit')
    end
  end
end
