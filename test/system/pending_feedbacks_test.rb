require "application_system_test_case"

class PendingFeedbacksTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit pending_feedbacks_url
  #
  #   assert_selector "h1", text: "PendingFeedback"
  # end

    #step 1: set up a pair request with no feedback
  
    setup do
      @user = users(:user_with_pending_feedback_as_author)
      # pair_requests method is calling the variable :one from the fixtures file pair_requests.yml
      @pair_request = pair_requests(:with_pending_feedback_by_author)
      mock_auth0(@user)
    end
  
    # setp 2: visit the index page
    test "visiting the root route" do
      # visit auth_user_path(@user)
      visit root_path
      click_button "Login"
      assert_selector :link, text: "Feedback Needed"

    end
  
    # step 3: click on the add feedback button, link
  
  
    # step 4: if user == auther, it should show feedback form for author, if user == acceptor, it should show feedback form for acceptor
  
  
    # step 5: user fill in the form
  
    # step 6: user  clicks on submit
  
  
    # step 7: 
      # a) user should be redirected to the pair request show page
      # b) the pair request should have feedback from the users who submitted the form
      # c) the pair request should no longer be in the pending feedback list
end
