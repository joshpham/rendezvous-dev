require 'test_helper'

class PhoneListsControllerTest < ActionController::TestCase
  setup do
    @phone_list = phone_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_list" do
    assert_difference('PhoneList.count') do
      post :create, phone_list: { business_id: @phone_list.business_id, name: @phone_list.name }
    end

    assert_redirected_to phone_list_path(assigns(:phone_list))
  end

  test "should show phone_list" do
    get :show, id: @phone_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phone_list
    assert_response :success
  end

  test "should update phone_list" do
    patch :update, id: @phone_list, phone_list: { business_id: @phone_list.business_id, name: @phone_list.name }
    assert_redirected_to phone_list_path(assigns(:phone_list))
  end

  test "should destroy phone_list" do
    assert_difference('PhoneList.count', -1) do
      delete :destroy, id: @phone_list
    end

    assert_redirected_to phone_lists_path
  end
end
