# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetings::UpdateComponent, type: :component do
  let(:empty_yesterday_meeting) { build(:standup_meeting, yesterday_work_description: '') }

  context 'with content to display' do
    let(:yesterday_work_description) { 'Lorem ipsum' }
    let(:today_work_description) { 'Sit amet' }
    let(:standup_meeting) do
      build(:standup_meeting, yesterday_work_description:, today_work_description:)
    end

    it "renders yesterday's content when passed the yesterday content type" do
      render_inline(
        described_class.new(standup_meeting:, content_type: :yesterday_work_description)
      )

      expect(page).to have_content(yesterday_work_description)
    end

    it "renders today's content when passed the today content type" do
      render_inline(
        described_class.new(standup_meeting:, content_type: :today_work_description)
      )

      expect(page).to have_content(today_work_description)
    end
  end

  context 'with no content to display' do
    let(:meeting_with_empty_yesterday) { build(:standup_meeting, yesterday_work_description: '') }

    it 'renders nothing' do
      render_inline(
        described_class.new(standup_meeting: meeting_with_empty_yesterday, content_type: :yesterday_work_description)
      )

      expect(page).not_to have_selector('body')
    end
  end
end
