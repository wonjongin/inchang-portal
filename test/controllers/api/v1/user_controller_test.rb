require "test_helper"

class Api::V1::UserControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get api_v1_user_list_url
    assert_response :success
  end

  test "should get edit" do
    get api_v1_user_edit_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_user_update_url
    assert_response :success
  end
end
