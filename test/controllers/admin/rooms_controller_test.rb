require 'test_helper'

class Admin::RoomsControllerTest < ActionController::TestCase
  setup do
    @admin_room = admin_rooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_rooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_room" do
    assert_difference('Admin::Room.count') do
      post :create, admin_room: {  }
    end

    assert_redirected_to admin_room_path(assigns(:admin_room))
  end

  test "should show admin_room" do
    get :show, id: @admin_room
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_room
    assert_response :success
  end

  test "should update admin_room" do
    patch :update, id: @admin_room, admin_room: {  }
    assert_redirected_to admin_room_path(assigns(:admin_room))
  end

  test "should destroy admin_room" do
    assert_difference('Admin::Room.count', -1) do
      delete :destroy, id: @admin_room
    end

    assert_redirected_to admin_rooms_path
  end
end
