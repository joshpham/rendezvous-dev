require 'test_helper'

class SuggestedsControllerTest < ActionController::TestCase
  setup do
    @suggested = suggesteds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:suggesteds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create suggested" do
    assert_difference('Suggested.count') do
      post :create, suggested: { name: @suggested.name }
    end

    assert_redirected_to suggested_path(assigns(:suggested))
  end

  test "should show suggested" do
    get :show, id: @suggested
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @suggested
    assert_response :success
  end

  test "should update suggested" do
    patch :update, id: @suggested, suggested: { name: @suggested.name }
    assert_redirected_to suggested_path(assigns(:suggested))
  end

  test "should destroy suggested" do
    assert_difference('Suggested.count', -1) do
      delete :destroy, id: @suggested
    end

    assert_redirected_to suggesteds_path
  end
end
