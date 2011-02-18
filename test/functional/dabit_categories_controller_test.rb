require 'test_helper'

class DabitCategoriesControllerTest < ActionController::TestCase
  setup do
    @dabit_category = dabit_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dabit_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dabit_category" do
    assert_difference('DabitCategory.count') do
      post :create, :dabit_category => @dabit_category.attributes
    end

    assert_redirected_to dabit_category_path(assigns(:dabit_category))
  end

  test "should show dabit_category" do
    get :show, :id => @dabit_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @dabit_category.to_param
    assert_response :success
  end

  test "should update dabit_category" do
    put :update, :id => @dabit_category.to_param, :dabit_category => @dabit_category.attributes
    assert_redirected_to dabit_category_path(assigns(:dabit_category))
  end

  test "should destroy dabit_category" do
    assert_difference('DabitCategory.count', -1) do
      delete :destroy, :id => @dabit_category.to_param
    end

    assert_redirected_to dabit_categories_path
  end
end
