require 'rails_helper'
RSpec.describe FeedbacksHelper, type: :helper do
  describe 'pending_feedback_link' do
    let(:pair_request_author) { create(:user) }
    let(:pair_request_invitee) { create(:user) }

    let(:pair_request) { create(:pair_request, author: pair_request_author, invitee: pair_request_invitee, status: :completed) }
 
    context "when the feedbac link is present and current_user == feedback.author" do
      it 'returns a link to the feedback' do
        binding.pry
        link = helper.pending_feedback_link(pair_request, pair_request_author)
        expect(link).to eq("<a class=\"btn bg-red-500\" href=\"/feedbacks/#{feedback.id}/edit\">Submit Feedback</a>")
      end
    end
  end
end
