require "test_helper"

class Api::V1::CarLogControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get api_v1_car_log_list_url
    assert_response :success
  end

  test "should get new_carlog" do
    get api_v1_car_log_new_carlog_url
    assert_response :success
  end

  test "should get create_carlog" do
    get api_v1_car_log_create_carlog_url
    assert_response :success
  end

  test "should get edit_carlog" do
    get api_v1_car_log_edit_carlog_url
    assert_response :success
  end

  test "should get update_carlog" do
    get api_v1_car_log_update_carlog_url
    assert_response :success
  end

  test "should get delete_carlog" do
    get api_v1_car_log_delete_carlog_url
    assert_response :success
  end
end
