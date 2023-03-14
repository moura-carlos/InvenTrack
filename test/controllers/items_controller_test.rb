require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  # sign_in method
  def sign_in(user)
    post session_path, params: { session: { email: user.email, password: 'password' } }
  end

  setup do
    @user = users(:one)
    sign_in @user
    @item = items(:one)

    # Attach image file
    @item.main_image.attach(io: File.open('test/fixtures/files/image.jpg'), filename: 'image.jpg', content_type: 'image/jpeg')
  end

  test "should get index" do
    get items_url
    assert_response :success
  end

  test "should get new" do
    get new_item_url
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post items_url, params: { item: { title: 'New Item', description: 'This is a valid description.', quantity: 5, price: 10.0, user_id: @user.id } }
    end
    assert_redirected_to item_path(Item.last)
    assert_equal 'Item successfully created!', flash[:notice]
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    patch item_url(@item), params: { item: { title: 'Updated Item', description: 'This is an updated description.', quantity: 7, price: 12.0 } }
    assert_redirected_to item_path(@item)
    assert_equal 'Item successfully updated', flash[:notice]
    @item.reload
    assert_equal 'Updated Item', @item.title
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end
    assert_redirected_to items_path
    assert_equal 'Item successfully deleted!', flash[:notice]
  end
end
