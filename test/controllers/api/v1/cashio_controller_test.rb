require "test_helper"

class Api::V1::CashioControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get api_v1_cashio_new_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_cashio_create_url
    assert_response :success
  end

  test "should get edit" do
    get api_v1_cashio_edit_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_cashio_update_url
    assert_response :success
  end

  test "should get delete" do
    get api_v1_cashio_delete_url
    assert_response :success
  end

  test "should get search" do
    get api_v1_cashio_search_url
    assert_response :success
  end
end
