require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def sign_in(user)
    post session_path, params: { session: { email: user.email, password: 'password' } }
  end

  def sign_out(user)
    delete session_path(user)
  end

  setup do
    @user = users(:one)
    @admin = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: 'New User', email: 'new_user@example.com', password: 'password', password_confirmation: 'password' } }
    end
    assert_redirected_to user_path(User.last)
    assert_equal 'Account successfully created!', flash[:notice]
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { name: 'Updated User', email: 'updated_user@example.com', password: 'password', password_confirmation: 'password' } }
    assert_redirected_to user_path(@user)
    assert_equal 'Account successfully updated', flash[:notice]
  end

  test "should destroy user" do
    sign_out @user
    sign_in @admin
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_path
    assert_equal 'Account successfully deleted!', flash[:notice]
  end

  test "should not allow non-admin to edit other users" do
    get edit_user_url(@admin)
    assert_redirected_to root_url
    assert_equal 'You are not authorized to do that!', flash[:notice]
  end

  test "should not allow non-admin to update other users" do
    patch user_url(@admin), params: { user: { name: 'Updated Admin', email: 'updated_admin@example.com', password: 'password', password_confirmation: 'password' } }
    assert_redirected_to root_url
    assert_equal 'You are not authorized to do that!', flash[:notice]
  end

  test "should not allow non-admin to destroy other users" do
    assert_no_difference('User.count') do
      delete user_url(@admin)
    end
    assert_redirected_to root_url
    assert_equal 'You are not authorized to do that!', flash[:notice]
  end
end
