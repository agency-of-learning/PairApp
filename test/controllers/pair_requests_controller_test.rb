require "test_helper"

class PairRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pair_request = pair_requests(:one)
  end

  test "should get index" do
    get pair_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_pair_request_url
    assert_response :success
  end

  test "should create pair_request" do
    assert_difference("PairRequest.count") do
      post pair_requests_url, params: { pair_request: { acceptor_id: @pair_request.acceptor_id, author_id: @pair_request.author_id, duration: @pair_request.duration, when: @pair_request.when } }
    end

    assert_redirected_to pair_request_url(PairRequest.last)
  end

  test "should show pair_request" do
    get pair_request_url(@pair_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_pair_request_url(@pair_request)
    assert_response :success
  end

  test "should update pair_request" do
    patch pair_request_url(@pair_request), params: { pair_request: { acceptor_id: @pair_request.acceptor_id, author_id: @pair_request.author_id, duration: @pair_request.duration, when: @pair_request.when } }
    assert_redirected_to pair_request_url(@pair_request)
  end

  test "should destroy pair_request" do
    assert_difference("PairRequest.count", -1) do
      delete pair_request_url(@pair_request)
    end

    assert_redirected_to pair_requests_url
  end
end
