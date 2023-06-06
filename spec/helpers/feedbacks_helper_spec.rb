require 'rails_helper'
RSpec.describe FeedbacksHelper, type: :helper do
  describe 'pending_feedback_link' do
    let(:pair_request_author) { create(:user) }
    let(:pair_request_invitee) { create(:user) }
    let(:random_user) { create(:user) }
    
    let(:pair_request) { create(:pair_request, :completed_with_feedback, author_id: pair_request_author.id, invitee_id: pair_request_invitee.id)}

    let(:author_feedback) { pair_request.author_feedback }
    let(:invitee_feedback) { pair_request.invitee_feedback }
 
    context "when current_user is the author and the pair_request is a draft" do
   
      it "it renders a submit feedback link to the correct feedback form" do
        link = helper.pending_feedback_link(pair_request, pair_request_author)
        expect(link).to eq("<a class=\"btn bg-red-500\" href=\"/feedbacks/#{author_feedback.id}/edit\">Submit Feedback</a>")
      end

      it "Doesn't renders a submit feedback link to opposite feedback form" do
        link = helper.pending_feedback_link(pair_request, pair_request_author)
        expect(link).not_to eq("<a class=\"btn bg-red-500\" href=\"/feedbacks/#{invitee_feedback.id}/edit\">Submit Feedback</a>")
      end

      it "Doesn't render a submit feedback link if current_user doesn't have a pending feedback" do
        link = helper.pending_feedback_link(pair_request, random_user)
        expect(link).to eq(nil)
      end
    end
  end
end