# frozen_string_literal: true

require "rails_helper"

RSpec.describe StandupMeetingGroup::CheckInStatusComponent, type: :component do
  let(:standup_meeting_group) { create(:standup_meeting_group) }
  let(:standup_meeting_group_2) { create(:standup_meeting_group) }
  let(:user) { create(:user) }
  let(:standup_meeting) { create(:standup_meeting, user: user, standup_meeting_group: standup_meeting_group, status: 'completed') }

  it "renders 'Checked in' message when user has checked in" do
    render_inline(described_class.new(standup_meeting_group, user))

    expect(page).to have_css("p", text: "Checked in")
  end

  it "renders 'Outstanding check-in' message when user has not checked in" do
    render_inline(described_class.new(standup_meeting_group_2, user))

    expect(page).to have_css("p", text: "Outstanding check-in")
  end
end
