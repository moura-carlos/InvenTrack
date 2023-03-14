require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session on valid credentials" do
    post session_url, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to user_path(@user)
    assert_equal "Welcome back, #{@user.name}!", flash[:success]
  end

  test "should not create session on invalid credentials" do
    post session_url, params: { session: { email: @user.email, password: 'wrong_password' } }
    assert_response :unprocessable_entity
    assert_equal "Invalid email or password", flash.now[:error]
  end

  test "should destroy session and log out" do
    post session_url, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to user_path(@user)

    delete session_url
    assert_redirected_to root_path
    assert_equal 'You have successfully logged out!', flash[:notice]
  end
end
