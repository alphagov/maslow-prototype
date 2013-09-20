require_relative '../integration_test_helper'

class ManageNeedsTest < ActionDispatch::IntegrationTest

  context "adding a need" do
    should "create a need with valid attributes" do
      visit "/needs"
      click_on "Add a new user need"

      assert page.has_field?("As a")
      assert page.has_field?("I need to")
      assert page.has_field?("so that")

      assert page.has_field?("Why is this needed?")
      assert page.has_field?("Evidence of the need")
      assert page.has_field?("How do we know when it's done?")

      fill_in "As a", :with => "user"
      fill_in "I need to", :with => "find my local register office"
      fill_in "so that", :with => "I can find records of a birth, marriage or death"

      fill_in "Why is this needed?", :with => "It's something that only government does"
      fill_in "Evidence of the need", :with => "50k search queries each month"
      fill_in "How do we know when it's done?", :with => "User can give location-specific information and see information about their local register office"

      click_on "Create Need"

      assert page.has_content?("Need has been created")

      within "table tbody tr" do
        assert page.has_content?("As a user I need to find my local register office so that I can find records of a birth, marriage or death")
        click_on "N1"
      end

      assert page.has_content? "As a user I need to find my local register office so that I can find records of a birth, marriage or death"
      assert page.has_content? "It's something that only government does"
      assert page.has_content? "50k search queries each month"
      assert page.has_content? "User can give location-specific information and see information about their local register office"
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
