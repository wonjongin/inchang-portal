require "test_helper"

class Api::V1::DiaryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get api_v1_diary_new_url
    assert_response :success
  end

  test "should get list" do
    get api_v1_diary_list_url
    assert_response :success
  end

  test "should get detail" do
    get api_v1_diary_detail_url
    assert_response :success
  end
end
