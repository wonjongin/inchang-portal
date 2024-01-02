require "test_helper"

class Api::V1::CarControllerTest < ActionDispatch::IntegrationTest
  test "should get car_list" do
    get api_v1_car_car_list_url
    assert_response :success
  end

  test "should get repair_list" do
    get api_v1_car_repair_list_url
    assert_response :success
  end

  test "should get new_car" do
    get api_v1_car_new_car_url
    assert_response :success
  end

  test "should get create_car" do
    get api_v1_car_create_car_url
    assert_response :success
  end

  test "should get new_repair" do
    get api_v1_car_new_repair_url
    assert_response :success
  end

  test "should get create_repair" do
    get api_v1_car_create_repair_url
    assert_response :success
  end

  test "should get edit_car" do
    get api_v1_car_edit_car_url
    assert_response :success
  end

  test "should get update_car" do
    get api_v1_car_update_car_url
    assert_response :success
  end

  test "should get update_repair" do
    get api_v1_car_update_repair_url
    assert_response :success
  end

  test "should get edit_repair" do
    get api_v1_car_edit_repair_url
    assert_response :success
  end

  test "should get sell_car" do
    get api_v1_car_sell_car_url
    assert_response :success
  end
end
