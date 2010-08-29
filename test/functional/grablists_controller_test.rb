require 'test_helper'

class GrablistsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grablists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grablist" do
    assert_difference('Grablist.count') do
      post :create, :grablist => { }
    end

    assert_redirected_to grablist_path(assigns(:grablist))
  end

  test "should show grablist" do
    get :show, :id => grablists(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => grablists(:one).to_param
    assert_response :success
  end

  test "should update grablist" do
    put :update, :id => grablists(:one).to_param, :grablist => { }
    assert_redirected_to grablist_path(assigns(:grablist))
  end

  test "should destroy grablist" do
    assert_difference('Grablist.count', -1) do
      delete :destroy, :id => grablists(:one).to_param
    end

    assert_redirected_to grablists_path
  end
end
