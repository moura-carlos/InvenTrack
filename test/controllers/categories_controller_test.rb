require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def sign_in(user)
    post session_path, params: { session: { email: user.email, password: 'password' } }
  end

  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: 'New Category' } }
    end
    assert_redirected_to categories_path
    assert_equal "Category was successfully created.", flash[:notice]
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    sign_in users(:admin)
    patch category_url(@category), params: { category: { name: 'Updated Category' } }
    assert_redirected_to categories_path
    assert_equal "Category was successfully updated.", flash[:notice]
  end

  test "should destroy category" do
    sign_in users(:admin)
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end
    assert_redirected_to categories_path
    assert_equal "Category was successfully deleted.", flash[:notice]
  end

  test "should not allow non-admin to edit" do
    get edit_category_url(@category)
    assert_redirected_to categories_path
    assert_equal "You are not authorized to do that!", flash[:notice]
  end

  test "should not allow non-admin to update" do
    patch category_url(@category), params: { category: { name: 'Updated Category' } }
    assert_redirected_to categories_path
    assert_equal "You are not authorized to do that!", flash[:notice]
  end

  test "should not allow non-admin to destroy" do
    assert_no_difference('Category.count') do
      delete category_url(@category)
    end
    assert_redirected_to categories_path
    assert_equal "You are not authorized to do that!", flash[:notice]
  end
end
