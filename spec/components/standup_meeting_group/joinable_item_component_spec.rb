# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetingGroup::JoinableItemComponent, type: :component do
  let(:standup_meeting_group) { create(:standup_meeting_group) }
  let(:user) { create(:user) }
  
  context 'when standup meeting group is present and user is not a member' do
    it 'renders the join button' do
      render_inline(described_class.new(standup_meeting_group: standup_meeting_group, current_user: user))

      expect(page).to have_css('button', text: 'Join')
    end
  end
end
