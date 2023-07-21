require "test_helper"

class Api::V1::FeedbackControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get api_v1_feedback_new_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_feedback_create_url
    assert_response :success
  end

  test "should get edit" do
    get api_v1_feedback_edit_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_feedback_update_url
    assert_response :success
  end
end
