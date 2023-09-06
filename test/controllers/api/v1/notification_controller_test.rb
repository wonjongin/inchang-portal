require "test_helper"

class Api::V1::NotificationControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get api_v1_notification_list_url
    assert_response :success
  end

  test "should get open" do
    get api_v1_notification_open_url
    assert_response :success
  end
end
