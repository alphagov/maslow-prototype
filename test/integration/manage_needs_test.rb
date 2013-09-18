require_relative '../integration_test_helper'

class ManageNeedsTest < ActionDispatch::IntegrationTest

  context "adding a need" do
    should "create a need with valid attributes" do
      visit "/needs"
      click_on "Add a new user need"

      assert page.has_field?("As a")
      assert page.has_field?("I need to")
      assert page.has_field?("so that")

      fill_in "As a", :with => "user"
      fill_in "I need to", :with => "find my local register office"
      fill_in "so that", :with => "I can find records of a birth, marriage or death"

      click_on "Create Need"

      assert page.has_content?("Need has been created")

      within "table" do
        assert page.has_content?("As a user I need to find my local register office so that I can find records of a birth, marriage or death")
      end
    end

    should "show error messages for a need with invalid attributes" do
      visit "/needs"
      click_on "Add a new user need"

      assert page.has_field?("As a")
      assert page.has_field?("I need to")
      assert page.has_field?("so that")

      fill_in "As a", :with => "user"
      fill_in "I need to", :with => "find my local register office"
      fill_in "so that", :with => ""

      click_on "Create Need"

      assert page.has_content?("There were problems creating this need. Please check the form.")

      within "form" do
        assert page.has_content?("can't be blank")
      end
    end
  end

end
