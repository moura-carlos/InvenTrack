require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    #@user = User.create(name: "User", email: "user@example.com", password: "password", password_confirmation: "password")
    @user = users(:one)
  end

  test "should not save item without title" do
    item = Item.new(description: "This is a description.", quantity: 5, price: 10.0, user_id: @user.id)
    assert_not item.save, "Saved the item without a title"
  end

  test "should not save item without description" do
    item = Item.new(title: "Title", quantity: 5, price: 10.0, user_id: @user.id)
    assert_not item.save, "Saved the item without a description"
  end

  test "should not save item with description length less than 20" do
    item = Item.new(title: "Title", description: "Short description.", quantity: 5, price: 10.0, user_id: @user.id)
    assert_not item.save, "Saved the item with a description length less than 20"
  end

  test "should not save item without quantity" do
    item = Item.new(title: "Title", description: "This is a description.", price: 10.0, user_id: @user.id)
    assert_not item.save, "Saved the item without a quantity"
  end

  test "should not save item with invalid quantity" do
    item = Item.new(title: "Title", description: "This is a description.", quantity: -5, price: 10.0, user_id: @user.id)
    assert_not item.save, "Saved the item with an invalid quantity"
  end

  test "should not save item without price" do
    item = Item.new(title: "Title", description: "This is a description.", quantity: 5, user_id: @user.id)
    assert_not item.save, "Saved the item without a price"
  end

  test "should not save item with price less than zero" do
    item = Item.new(title: "Title", description: "This is a description.", quantity: 5, price: -5.0, user_id: @user.id)
    assert_not item.save, "Saved the item with a price less than zero"
  end

  test "should save item with acceptable image" do
    item = Item.new(title: "Title", description: "This is a description.", quantity: 5, price: 10.0, user_id: @user.id)
    image = Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'image.jpg'), 'image/jpeg')
    item.main_image.attach(io: image, filename: 'image.jpg', content_type: 'image/jpeg')
    assert item.save, "Could not save the item with an acceptable image"
  end


  test "should not save item with image that is too big" do
    item = Item.new(title: "Title", description: "This is a description.", quantity: 5, price: 10.0, user_id: @user.id)
    image = Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'large_image.jpg'), 'image/jpeg')
    item.main_image.attach(io: image, filename: 'large_image.jpg', content_type: 'image/jpeg')
    assert_not item.save, "Saved the item with an image that is too big"
  end

  test "should not save item with image that is not a JPEG or PNG" do
    item = Item.new(title: "Title", description: "This is a description.", quantity: 5, price: 10.0, user_id: @user.id)
    image = Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'invalid_image.gif'), 'image/gif')
    item.main_image.attach(io: image, filename: 'invalid_image.gif', content_type: 'image/gif')
    assert_not item.save, "Saved the item with an image that is not a JPEG or PNG"
  end
end
