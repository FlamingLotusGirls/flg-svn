require 'test_helper'

class PoofersControllerTest < ActionController::TestCase
  setup do
    @poofer = poofers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poofers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poofer" do
    assert_difference('Poofer.count') do
      post :create, :poofer => @poofer.attributes
    end

    assert_redirected_to poofer_path(assigns(:poofer))
  end

  test "should show poofer" do
    get :show, :id => @poofer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @poofer.to_param
    assert_response :success
  end

  test "should update poofer" do
    put :update, :id => @poofer.to_param, :poofer => @poofer.attributes
    assert_redirected_to poofer_path(assigns(:poofer))
  end

  test "should destroy poofer" do
    assert_difference('Poofer.count', -1) do
      delete :destroy, :id => @poofer.to_param
    end

    assert_redirected_to poofers_path
  end
end
