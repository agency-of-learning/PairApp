# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeeting::DateNavigatorComponent, type: :component do
  let(:standup_meeting_group) { create(:standup_meeting_group) }
  let(:meeting_date) { Date.current }

  context 'when the meeting date is less than or equal to date options' do
    let(:date_options) { [meeting_date, meeting_date.tomorrow] }

    it 'only has an active link for navigating to the next date' do
      render_inline(
        described_class.new(standup_meeting_group:, meeting_date:, date_options:)
      )

      expect(page).not_to have_link('Previous')
      expect(page).to have_link('GO')
      expect(page).to have_link('Next')
    end
  end

  context 'when the meeting date is larger than or equal to date options' do
    let(:date_options) { [meeting_date, meeting_date.yesterday] }

    it 'only has an active link for navigating to the previous date' do
      render_inline(
        described_class.new(standup_meeting_group:, meeting_date:, date_options:)
      )

      expect(page).to have_link('Previous')
      expect(page).to have_link('GO')
      expect(page).not_to have_link('Next')
    end
  end

  context 'when the meeting date is between the date options' do
    let(:date_options) { [meeting_date, meeting_date.yesterday, meeting_date.tomorrow] }

    it 'only has active links for navigating to previous and next date' do
      render_inline(
        described_class.new(standup_meeting_group:, meeting_date:, date_options:)
      )

      expect(page).to have_link('Previous')
      expect(page).to have_link('GO')
      expect(page).to have_link('Next')
    end
  end
end
