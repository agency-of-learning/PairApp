# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetings::SkipButtonComponent, type: :component do
  let(:user) { create(:user) }
  let(:standup_meeting_group) { create(:standup_meeting_group) }
  let(:standup_meeting) { create(:standup_meeting, user:, standup_meeting_group:, status:) }

  context 'when the standup meeting is completed' do
    let(:status) { :completed }

    it 'renders nothing' do
      render_inline(described_class.new(standup_meeting:, standup_meeting_group:, current_user: user))

      expect(page).not_to have_selector('body')
    end
  end

  context 'when the standup meeting is already skipped' do
    let(:status) { :skipped }

    it 'renders nothing' do
      render_inline(described_class.new(standup_meeting:, standup_meeting_group:, current_user: user))

      expect(page).not_to have_selector('body')
    end
  end

  context 'when the standup meeting is in draft' do
    let(:status) { :draft }

    it 'renders the skip button' do
      render_inline(described_class.new(standup_meeting:, standup_meeting_group:, current_user: user))

      expect(page).to have_button('Skip')
    end
  end

  context 'when the standup meeting is not persisted to the database' do
    let(:standup_meeting) { build(:standup_meeting, user:, standup_meeting_group:) }

    it 'renders nothing' do
      render_inline(described_class.new(standup_meeting:, standup_meeting_group:, current_user: user))

      expect(page).not_to have_selector('body')
    end
  end

  context 'when the meeting does not belong to the user' do
    let(:standup_meeting) { create(:standup_meeting, standup_meeting_group:) }

    it 'renders nothing' do
      render_inline(described_class.new(standup_meeting:, standup_meeting_group:, current_user: user))

      expect(page).not_to have_selector('body')
    end
  end
end
