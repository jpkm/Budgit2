require 'test_helper'

class CreditCategoriesControllerTest < ActionController::TestCase
  setup do
    @credit_category = credit_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:credit_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create credit_category" do
    assert_difference('CreditCategory.count') do
      post :create, :credit_category => @credit_category.attributes
    end

    assert_redirected_to credit_category_path(assigns(:credit_category))
  end

  test "should show credit_category" do
    get :show, :id => @credit_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @credit_category.to_param
    assert_response :success
  end

  test "should update credit_category" do
    put :update, :id => @credit_category.to_param, :credit_category => @credit_category.attributes
    assert_redirected_to credit_category_path(assigns(:credit_category))
  end

  test "should destroy credit_category" do
    assert_difference('CreditCategory.count', -1) do
      delete :destroy, :id => @credit_category.to_param
    end

    assert_redirected_to credit_categories_path
  end
end
