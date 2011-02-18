require 'test_helper'

class DebitCategoriesControllerTest < ActionController::TestCase
  setup do
    @debit_category = debit_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debit_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debit_category" do
    assert_difference('DebitCategory.count') do
      post :create, :debit_category => @debit_category.attributes
    end

    assert_redirected_to debit_category_path(assigns(:debit_category))
  end

  test "should show debit_category" do
    get :show, :id => @debit_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @debit_category.to_param
    assert_response :success
  end

  test "should update debit_category" do
    put :update, :id => @debit_category.to_param, :debit_category => @debit_category.attributes
    assert_redirected_to debit_category_path(assigns(:debit_category))
  end

  test "should destroy debit_category" do
    assert_difference('DebitCategory.count', -1) do
      delete :destroy, :id => @debit_category.to_param
    end

    assert_redirected_to debit_categories_path
  end
end
