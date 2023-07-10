# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeeting::DateNavigatorComponent, type: :component do
  let(:standup_meeting_group) { create(:standup_meeting_group) }
  let(:meeting_date) { Date.current }

  it 'only has active links for navigating to previous and next date' do
    render_inline(
      described_class.new(standup_meeting_group:, meeting_date:)
    )

    expect(page).to have_link('Previous')
    expect(page).to have_link('GO')
    expect(page).to have_link('Next')
  end
end
