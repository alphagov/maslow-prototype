require_relative '../test_helper'

class NeedTest < ActiveSupport::TestCase

  context "creating a need" do
    setup do
      @organisation = Organisation.create!(:name => "Ministry of Magic", :slug => "ministry-of-magic")
      @atts = {
        :story_role => "user",
        :story_goal => "pay my council tax",
        :story_benefit => "I do not receive a fine",
        :organisation_id => @organisation.id,
        :justification => "only_the_government_provides",
        :evidence => "100k search requests for 'council tax'",
        :done_criteria => "Informs users about conditions A & B of statute"
      }
    end

    should "be created with valid attributes" do
      need = Need.new(@atts)

      assert need.valid?
      assert need.save!

      need.reload

      assert_equal "user", need.story_role
      assert_equal "pay my council tax", need.story_goal
      assert_equal "I do not receive a fine", need.story_benefit
      assert_equal "Ministry of Magic", need.organisation.name
      assert_equal "only_the_government_provides", need.justification
      assert_equal "100k search requests for 'council tax'", need.evidence
      assert_equal "Informs users about conditions A & B of statute", need.done_criteria
    end

    should "assign an incremented identifier to a new need" do
      need_one = Need.create!(@atts)
      need_two = Need.create!(@atts)
      need_three = Need.create!(@atts.merge(:reference => 100))
      need_four = Need.create!(@atts)

      assert_equal 1, need_one.reference
      assert_equal 2, need_two.reference
      assert_equal 100, need_three.reference
      assert_equal 101, need_four.reference
    end

    should "calculate the completion percentage on save" do
      need = Need.new(@atts)
      need.save!

      assert_equal 100, need.completion

      need.justification = ""
      need.evidence = ""
      need.save!

      assert_equal 66, need.completion
    end

    should "not be valid without a story goal" do
      need = Need.new(@atts.merge(:story_goal => ''))

      refute need.valid?
      assert need.errors.has_key?(:story_goal)
    end

    should "not be valid with a duplicate need reference" do
      Need.create!(@atts.merge(:reference => 42))
      need = Need.new(@atts.merge(:reference => 42))

      refute need.valid?
      assert need.errors.has_key?(:reference)
    end
  end

  context "given an existing need" do
    setup do
      @need = Need.create!(
        :story_role => "user",
        :story_goal => "pay my council tax",
        :story_benefit => "I do not receive a fine",
        :reference => 42
      )
    end

    should "return the whole story" do
      story = @need.story
      assert_equal "As a user I need to pay my council tax so that I do not receive a fine", story
    end

    should "return a formatted reference" do
      reference = @need.whole_reference
      assert_equal "42", reference
    end
  end

end
