require "application_system_test_case"

class SecondhandsTest < ApplicationSystemTestCase
  setup do
    @secondhand = secondhands(:one)
  end

  test "visiting the index" do
    visit secondhands_url
    assert_selector "h1", text: "Secondhands"
  end

  test "should create secondhand" do
    visit secondhands_url
    click_on "New secondhand"

    fill_in "Book", with: @secondhand.book_id
    fill_in "Description", with: @secondhand.description
    fill_in "User", with: @secondhand.user_id
    click_on "Create Secondhand"

    assert_text "Secondhand was successfully created"
    click_on "Back"
  end

  test "should update Secondhand" do
    visit secondhand_url(@secondhand)
    click_on "Edit this secondhand", match: :first

    fill_in "Book", with: @secondhand.book_id
    fill_in "Description", with: @secondhand.description
    fill_in "User", with: @secondhand.user_id
    click_on "Update Secondhand"

    assert_text "Secondhand was successfully updated"
    click_on "Back"
  end

  test "should destroy Secondhand" do
    visit secondhand_url(@secondhand)
    click_on "Destroy this secondhand", match: :first

    assert_text "Secondhand was successfully destroyed"
  end
end
