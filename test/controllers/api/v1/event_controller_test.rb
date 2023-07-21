require "test_helper"

class Api::V1::EventControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get api_v1_event_new_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_event_create_url
    assert_response :success
  end
end
