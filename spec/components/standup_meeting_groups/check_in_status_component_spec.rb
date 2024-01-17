# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StandupMeetingGroups::CheckInStatusComponent, type: :component do
  let(:user) { create(:user) }

  let(:standup_meeting_group_with_checkin) do
    create(:standup_meeting_group).tap do |group|
      group.standup_meetings << create(:standup_meeting, user:, status: 'completed')
    end
  end

  let(:standup_meeting_group_no_checkin) { create(:standup_meeting_group) }

  let(:standup_meeting_group_with_skip) do
    create(:standup_meeting_group).tap do |group|
      group.standup_meetings << create(:standup_meeting, user:, status: :skipped)
    end
  end

  it "renders 'Checked in' message when user has checked in" do
    render_inline(described_class.new(standup_meeting_group: standup_meeting_group_with_checkin, current_user: user))

    expect(page).to have_content('Checked in')
  end

  it "renders 'Outstanding check-in' message when user has not checked in" do
    render_inline(described_class.new(standup_meeting_group: standup_meeting_group_no_checkin, current_user: user))

    expect(page).to have_content('Outstanding check-in')
  end

  it "renders 'You skipped your check-in today' when the user has skipped their meeting" do
    render_inline(described_class.new(standup_meeting_group: standup_meeting_group_with_skip, current_user: user))

    expect(page).to have_content('You skipped your check-in today')
  end
end
