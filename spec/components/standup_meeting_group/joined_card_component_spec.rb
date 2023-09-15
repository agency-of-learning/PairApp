# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetingGroup::JoinedCardComponent, type: :component do
  let(:standup_meeting_group) { create(:standup_meeting_group, name: 'Test Group') }
  let(:user) { create(:user) }

  it 'renders the joined card with the right name' do
    render_inline(described_class.new(standup_meeting_group:, current_user: user))

    expect(page).to have_css('h4', text: 'Test Group')
  end
end
