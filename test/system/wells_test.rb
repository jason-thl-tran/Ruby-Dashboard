require "application_system_test_case"

class WellsTest < ApplicationSystemTestCase
  setup do
    @well = wells(:one)
  end

  test "visiting the index" do
    visit wells_url
    assert_selector "h1", text: "Wells"
  end

  test "should create well" do
    visit wells_url
    click_on "New well"

    fill_in "Md", with: @well.md
    fill_in "Name", with: @well.name
    fill_in "State", with: @well.state
    fill_in "Status", with: @well.status
    fill_in "Tvd", with: @well.tvd
    click_on "Create Well"

    assert_text "Well was successfully created"
    click_on "Back"
  end

  test "should update Well" do
    visit well_url(@well)
    click_on "Edit this well", match: :first

    fill_in "Md", with: @well.md
    fill_in "Name", with: @well.name
    fill_in "State", with: @well.state
    fill_in "Status", with: @well.status
    fill_in "Tvd", with: @well.tvd
    click_on "Update Well"

    assert_text "Well was successfully updated"
    click_on "Back"
  end

  test "should destroy Well" do
    visit well_url(@well)
    click_on "Destroy this well", match: :first

    assert_text "Well was successfully destroyed"
  end
end
