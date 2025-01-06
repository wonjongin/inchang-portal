require "test_helper"

class Api::V1::VacationsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get api_v1_vacations_list_url
    assert_response :success
  end

  test "should get detail" do
    get api_v1_vacations_detail_url
    assert_response :success
  end

  test "should get new" do
    get api_v1_vacations_new_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_vacations_create_url
    assert_response :success
  end

  test "should get edit" do
    get api_v1_vacations_edit_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_vacations_update_url
    assert_response :success
  end

  test "should get delete" do
    get api_v1_vacations_delete_url
    assert_response :success
  end
end
