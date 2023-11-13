require "rails_helper"

RSpec.describe "POST /standup_meeting_groups/:standup_meeting_group_id/joins", type: :request do
  let!(:user) { create(:user) }
  let!(:standup_meeting_group) { create(:standup_meeting_group) }

  before do
    sign_in user
  end

  context "when the standup meeting group user does not exist" do
    it "creates the standup meeting group user" do
      post "/standup_meeting_groups/#{standup_meeting_group.id}/joins",
           params: {
             standup_meeting_group_id: standup_meeting_group.id,
             format: :turbo_stream
           }

      smgu = StandupMeetingGroupUser.first
      expect(smgu.user_id).to eq(user.id)
      expect(smgu.standup_meeting_group_id).to eq(standup_meeting_group.id) 
    end
  end

  context "when the standup meeting group user exists" do
    it "does not create the standup meeting group user" do
      # Create the same user before posting to make sure the save fails.
      StandupMeetingGroupUser.create(
        user: user,
        standup_meeting_group: standup_meeting_group
      )

      post "/standup_meeting_groups/#{standup_meeting_group.id}/joins",
           params: {
             standup_meeting_group_id: standup_meeting_group.id,
             format: :turbo_stream
           }

      expect(StandupMeetingGroupUser.where(
        user: user,
        standup_meeting_group: standup_meeting_group
      ).count).to eq 1
    end
  end
end
