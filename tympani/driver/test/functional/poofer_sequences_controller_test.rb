require 'test_helper'

class PooferSequencesControllerTest < ActionController::TestCase
  setup do
    @poofer_sequence = poofer_sequences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poofer_sequences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poofer_sequence" do
    assert_difference('PooferSequence.count') do
      post :create, :poofer_sequence => @poofer_sequence.attributes
    end

    assert_redirected_to poofer_sequence_path(assigns(:poofer_sequence))
  end

  test "should show poofer_sequence" do
    get :show, :id => @poofer_sequence.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @poofer_sequence.to_param
    assert_response :success
  end

  test "should update poofer_sequence" do
    put :update, :id => @poofer_sequence.to_param, :poofer_sequence => @poofer_sequence.attributes
    assert_redirected_to poofer_sequence_path(assigns(:poofer_sequence))
  end

  test "should destroy poofer_sequence" do
    assert_difference('PooferSequence.count', -1) do
      delete :destroy, :id => @poofer_sequence.to_param
    end

    assert_redirected_to poofer_sequences_path
  end
end
