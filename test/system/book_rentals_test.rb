require "application_system_test_case"

class BookRentalsTest < ApplicationSystemTestCase
  setup do
    @book_rental = book_rentals(:one)
  end

  test "visiting the index" do
    visit book_rentals_url
    assert_selector "h1", text: "Book rentals"
  end

  test "should create book rental" do
    visit book_rentals_url
    click_on "New book rental"

    fill_in "Isbn", with: @book_rental.ISBN
    fill_in "End", with: @book_rental.end
    fill_in "Matricola", with: @book_rental.matricola
    fill_in "Start", with: @book_rental.start
    click_on "Create Book rental"

    assert_text "Book rental was successfully created"
    click_on "Back"
  end

  test "should update Book rental" do
    visit book_rental_url(@book_rental)
    click_on "Edit this book rental", match: :first

    fill_in "Isbn", with: @book_rental.ISBN
    fill_in "End", with: @book_rental.end
    fill_in "Matricola", with: @book_rental.matricola
    fill_in "Start", with: @book_rental.start
    click_on "Update Book rental"

    assert_text "Book rental was successfully updated"
    click_on "Back"
  end

  test "should destroy Book rental" do
    visit book_rental_url(@book_rental)
    click_on "Destroy this book rental", match: :first

    assert_text "Book rental was successfully destroyed"
  end
end
