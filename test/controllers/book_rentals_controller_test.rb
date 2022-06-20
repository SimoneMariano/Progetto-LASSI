require "test_helper"

class BookRentalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_rental = book_rentals(:one)
  end

  test "should get index" do
    get book_rentals_url
    assert_response :success
  end

  test "should get new" do
    get new_book_rental_url
    assert_response :success
  end

  test "should create book_rental" do
    assert_difference("BookRental.count") do
      post book_rentals_url, params: { book_rental: { ISBN: @book_rental.ISBN, end: @book_rental.end, matricola: @book_rental.matricola, start: @book_rental.start } }
    end

    assert_redirected_to book_rental_url(BookRental.last)
  end

  test "should show book_rental" do
    get book_rental_url(@book_rental)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_rental_url(@book_rental)
    assert_response :success
  end

  test "should update book_rental" do
    patch book_rental_url(@book_rental), params: { book_rental: { ISBN: @book_rental.ISBN, end: @book_rental.end, matricola: @book_rental.matricola, start: @book_rental.start } }
    assert_redirected_to book_rental_url(@book_rental)
  end

  test "should destroy book_rental" do
    assert_difference("BookRental.count", -1) do
      delete book_rental_url(@book_rental)
    end

    assert_redirected_to book_rentals_url
  end
end
