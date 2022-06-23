require "test_helper"

class SecondhandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @secondhand = secondhands(:one)
  end

  test "should get index" do
    get secondhands_url
    assert_response :success
  end

  test "should get new" do
    get new_secondhand_url
    assert_response :success
  end

  test "should create secondhand" do
    assert_difference("Secondhand.count") do
      post secondhands_url, params: { secondhand: { book_id: @secondhand.book_id, description: @secondhand.description, user_id: @secondhand.user_id } }
    end

    assert_redirected_to secondhand_url(Secondhand.last)
  end

  test "should show secondhand" do
    get secondhand_url(@secondhand)
    assert_response :success
  end

  test "should get edit" do
    get edit_secondhand_url(@secondhand)
    assert_response :success
  end

  test "should update secondhand" do
    patch secondhand_url(@secondhand), params: { secondhand: { book_id: @secondhand.book_id, description: @secondhand.description, user_id: @secondhand.user_id } }
    assert_redirected_to secondhand_url(@secondhand)
  end

  test "should destroy secondhand" do
    assert_difference("Secondhand.count", -1) do
      delete secondhand_url(@secondhand)
    end

    assert_redirected_to secondhands_url
  end
end
