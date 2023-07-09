# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeeting::CheckInCtaComponent, type: :component do
  context 'when the standup meeting is a draft' do
    let(:standup_meeting) { create(:standup_meeting) }
    let(:standup_meeting_group) { standup_meeting.standup_meeting_group }
    let(:current_user) { standup_meeting.user }

    context 'with a pair request that can be accepted or rejected' do
      it 'renders a Skip Button and Check In link' do
        render_inline(
          described_class.new(standup_meeting:, standup_meeting_group:, current_user:)
        )

        expect(page).to have_content('You have not yet checked in today!')
        expect(page).to have_link('Check in')
        expect(page).to have_button('Skip')
      end
    end
  end

  context 'when the standup meeting is skipped' do
    let(:standup_meeting) { create(:standup_meeting, :skipped) }
    let(:current_user) { standup_meeting.user }
    let(:standup_meeting_group) { standup_meeting.standup_meeting_group }

    it 'renders a Check In link' do
      render_inline(
        described_class.new(standup_meeting:, standup_meeting_group:, current_user:)
      )

      expect(page).to have_content('You skipped your check-in today')
      expect(page).to have_link('Check in')
    end
  end

  context 'when the standup meeting is completed' do
    let(:standup_meeting) { create(:standup_meeting, :completed) }
    let(:current_user) { standup_meeting.user }
    let(:standup_meeting_group) { standup_meeting.standup_meeting_group }

    it 'renders an Edit Response link' do
      render_inline(
        described_class.new(standup_meeting:, standup_meeting_group:, current_user:)
      )

      expect(page).to have_content('You checked in today!')
      expect(page).to have_link('Edit Response')
    end
  end

  # it "renders something useful" do
  #   expect(
  #     render_inline(described_class.new(attr: "value")) { "Hello, components!" }.css("p").to_html
  #   ).to include(
  #     "Hello, components!"
  #   )
  # end
end
