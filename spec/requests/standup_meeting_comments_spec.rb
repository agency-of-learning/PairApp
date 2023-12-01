require 'rails_helper'

RSpec.describe 'StandupMeetingComments' do
  let!(:user) { create(:user) }
  let!(:standup_meeting) { create(:standup_meeting) }
  let!(:standup_meeting_comment) { create(:standup_meeting_comment, user:, standup_meeting:) }

  before do
    sign_in user
  end

  # describe 'GET /edit' do
  #   it 'returns http success' do
  #     get '/standup_meeting_comments/edit'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe 'DELETE /standup_meeting_comments/:id' do
    it 'deletes the standup meeting comment' do
      expect {
        delete standup_meeting_standup_meeting_comment_path(standup_meeting.id, standup_meeting_comment)
      }.to change(StandupMeetingComment, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(flash[:notice]).to eq 'Comment was successfully deleted.'
    end
  end
end
