# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetingGroup::JoinableItemComponent, type: :component do
  let(:standup_meeting_group) { create(:standup_meeting_group) }
  let(:user) { create(:user) }

  context 'when standup meeting group is present and user is not a member' do
    it 'renders a join button' do
      render_inline(
        described_class.new(standup_meeting_group:, current_user: user)
      )
      expect(page).to have_button('Join')
    end
  end

  # context 'When a standup meeting group is present and the user is a member' do
  #   it 'renders a leave button' do
  #     standup_meeting_group.users << user

  #     # render_inline(
  #     #   described_class.new(standup_meeting_group: standup_meeting_group, current_user: user)
  #     # )
  #     # expect(page).not_to have_button('Join')
  #   end
  # end
end
