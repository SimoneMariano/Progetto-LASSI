require "application_system_test_case"

class ViewReservationsTest < ApplicationSystemTestCase
  setup do
    @view_reservation = view_reservations(:one)
  end

  test "visiting the index" do
    visit view_reservations_url
    assert_selector "h1", text: "View reservations"
  end

  test "should create view reservation" do
    visit view_reservations_url
    click_on "New view reservation"

    click_on "Create View reservation"

    assert_text "View reservation was successfully created"
    click_on "Back"
  end

  test "should update View reservation" do
    visit view_reservation_url(@view_reservation)
    click_on "Edit this view reservation", match: :first

    click_on "Update View reservation"

    assert_text "View reservation was successfully updated"
    click_on "Back"
  end

  test "should destroy View reservation" do
    visit view_reservation_url(@view_reservation)
    click_on "Destroy this view reservation", match: :first

    assert_text "View reservation was successfully destroyed"
  end
end
