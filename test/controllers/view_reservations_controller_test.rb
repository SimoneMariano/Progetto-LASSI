require "test_helper"

class ViewReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @view_reservation = view_reservations(:one)
  end

  test "should get index" do
    get view_reservations_url
    assert_response :success
  end

  test "should get new" do
    get new_view_reservation_url
    assert_response :success
  end

  test "should create view_reservation" do
    assert_difference("ViewReservation.count") do
      post view_reservations_url, params: { view_reservation: {  } }
    end

    assert_redirected_to view_reservation_url(ViewReservation.last)
  end

  test "should show view_reservation" do
    get view_reservation_url(@view_reservation)
    assert_response :success
  end

  test "should get edit" do
    get edit_view_reservation_url(@view_reservation)
    assert_response :success
  end

  test "should update view_reservation" do
    patch view_reservation_url(@view_reservation), params: { view_reservation: {  } }
    assert_redirected_to view_reservation_url(@view_reservation)
  end

  test "should destroy view_reservation" do
    assert_difference("ViewReservation.count", -1) do
      delete view_reservation_url(@view_reservation)
    end

    assert_redirected_to view_reservations_url
  end
end
