# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetingGroup::JoinableItemComponent, type: :component do
  context 'when standup meeting group is present and user is not a member' do
    let(:standup_meeting_group) { create(:standup_meeting_group) }
    let(:user) { create(:user) }
    let(:my_standup_meeting_groups) { user.standup_meeting_groups }

    it 'renders the join button' do
      render_inline(
        described_class.new(
          standup_meeting_group:,
          my_standup_meeting_groups:,
          current_user: user
        )
      )

      expect(page).to have_button(text: 'Join')
    end
  end

  context 'when standup meeting group is present and user is a member' do
    let(:standup_meeting_group_user) { create(:standup_meeting_group_user) }
    let(:my_standup_meeting_groups) { user.standup_meeting_groups }
    let(:standup_meeting_group) { standup_meeting_group_user.standup_meeting_group }
    let(:user) { standup_meeting_group_user.user }

    it 'renders the leave button' do
      render_inline(
        described_class.new(
          standup_meeting_group:,
          my_standup_meeting_groups:,
          current_user: user
        )
      )

      expect(page).to have_button(text: 'Leave')
    end
  end
end
