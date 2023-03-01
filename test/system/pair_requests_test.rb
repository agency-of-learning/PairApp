require "application_system_test_case"

class PairRequestsTest < ApplicationSystemTestCase
  setup do
    @pair_request = pair_requests(:one)
  end

  test "visiting the index" do
    visit pair_requests_url
    assert_selector "h1", text: "Pair requests"
  end

  test "should create pair request" do
    visit pair_requests_url
    click_on "New pair request"

    fill_in "Acceptor", with: @pair_request.acceptor_id
    fill_in "Author", with: @pair_request.author_id
    fill_in "Duration", with: @pair_request.duration
    fill_in "When", with: @pair_request.when
    click_on "Create Pair request"

    assert_text "Pair request was successfully created"
    click_on "Back"
  end

  test "should update Pair request" do
    visit pair_request_url(@pair_request)
    click_on "Edit this pair request", match: :first

    fill_in "Acceptor", with: @pair_request.acceptor_id
    fill_in "Author", with: @pair_request.author_id
    fill_in "Duration", with: @pair_request.duration
    fill_in "When", with: @pair_request.when
    click_on "Update Pair request"

    assert_text "Pair request was successfully updated"
    click_on "Back"
  end

  test "should destroy Pair request" do
    visit pair_request_url(@pair_request)
    click_on "Destroy this pair request", match: :first

    assert_text "Pair request was successfully destroyed"
  end
end
