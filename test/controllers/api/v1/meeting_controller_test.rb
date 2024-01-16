require "test_helper"

class Api::V1::MeetingControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get api_v1_meeting_list_url
    assert_response :success
  end

  test "should get new_meeting" do
    get api_v1_meeting_new_meeting_url
    assert_response :success
  end

  test "should get create_meeting" do
    get api_v1_meeting_create_meeting_url
    assert_response :success
  end

  test "should get edit_meeting" do
    get api_v1_meeting_edit_meeting_url
    assert_response :success
  end

  test "should get update_meeting" do
    get api_v1_meeting_update_meeting_url
    assert_response :success
  end

  test "should get delete_meeting" do
    get api_v1_meeting_delete_meeting_url
    assert_response :success
  end
end
