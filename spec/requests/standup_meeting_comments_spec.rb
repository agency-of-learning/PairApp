require 'rails_helper'

RSpec.describe "StandupMeetingComments", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/standup_meeting_comments/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/standup_meeting_comments/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/standup_meeting_comments/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/standup_meeting_comments/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
