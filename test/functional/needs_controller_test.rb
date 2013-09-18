require_relative '../test_helper'

class NeedsControllerTest < ActionController::TestCase

  context "GET index" do
    setup do
      @needs = FactoryGirl.create_list(:need, 10)
    end

    should "be successful" do
      get :index
      assert_response :success
    end

    should "assign a collection of needs" do
      get :index

      assert_equal 10, assigns(:needs).size
      assert_equal (1..10).to_a, assigns(:needs).map(&:reference)
    end

    should "render the index view" do
      get :index
      assert_template :index
    end
  end

  context "GET new" do
    should "be successful" do
      get :new
      assert_response :success
    end

    should "assign a new need" do
      get :new
      assert assigns(:need).is_a?(Need)
    end

    should "render the new need form" do
      get :new
      assert_template :new
    end
  end

  context "POST create" do
    should "create a need given valid attributes" do
      post :create, :need => {
        :story_role => "user",
        :story_goal => "register for self assessment",
        :story_benefit => "send a self assessment tax return"
      }
      assert_redirected_to(:action => :index)

      need = Need.first
      assert_equal "user", need.story_role
      assert_equal "register for self assessment", need.story_goal
      assert_equal "send a self assessment tax return", need.story_benefit
    end

    should "render the new form with errors given invalid attributes" do
      post :create, :need => {
        :story_role => "",
        :story_goal => "",
        :story_benefit => "foo"
      }

      assert_template :new
      assert_equal 0, Need.count
      assert assigns(:need).errors.any?
    end
  end

  context "GET show" do
    context "given an existing need" do
      setup do
        @need = FactoryGirl.create(:need)
      end

      should "be successful" do
        get :show, :id => @need.id
        assert_response :success
      end

      should "assign the need to the view" do
        get :show, :id => @need.id

        assert assigns(:need).present?
        assert_equal @need.story_role, assigns(:need).story_role
        assert_equal @need.story_goal, assigns(:need).story_goal
        assert_equal @need.story_benefit, assigns(:need).story_benefit
      end

      should "render the view template" do
        get :show, :id => @need.id
        assert_template :show
      end
    end

    should "raise a not found error for a need which doesn't exist" do
      get :show, :id => "1234"
      assert_response :not_found
    end
  end

  context "GET edit" do
    context "given an existing need" do
      setup do
        @need = FactoryGirl.create(:need)
      end

      should "be successful" do
        get :edit, :id => @need.id
        assert_response :success
      end

      should "assign the need to the view" do
        get :edit, :id => @need.id

        assert assigns(:need).present?
        assert_equal @need.story_role, assigns(:need).story_role
        assert_equal @need.story_goal, assigns(:need).story_goal
        assert_equal @need.story_benefit, assigns(:need).story_benefit
      end

      should "render the edit form" do
        get :edit, :id => @need.id
        assert_template :edit
      end
    end

    should "raise a not found error for a need which doesn't exist" do
      get :edit, :id => "1234"
      assert_response :not_found
    end
  end

  context "PUT update" do
    context "given an existing need" do
      setup do
        @need = FactoryGirl.create(:need, :story_goal => "pay my council tax")
      end

      should "create a need given valid attributes" do
        put :update, :id => @need.id, :need => {
          :story_role => "user",
          :story_goal => "update my self assessment details",
          :story_benefit => "I can stay up to date"
        }
        assert_redirected_to(:action => :index)

        @need.reload
        assert_equal "user", @need.story_role
        assert_equal "update my self assessment details", @need.story_goal
        assert_equal "I can stay up to date", @need.story_benefit
      end

      should "render the new form with errors given invalid attributes" do
        put :update, :id => @need.id, :need => {
          :story_role => "user",
          :story_goal => "update my self assessment details",
          :story_benefit => ""
        }

        assert_template :edit
        assert assigns(:need).errors.any?

        @need.reload
        assert_equal "pay my council tax", @need.story_goal
      end
    end

    should "raise a not found error for a need which doesn't exist" do
      put :update, :id => "1234"
      assert_response :not_found
    end
  end

end
