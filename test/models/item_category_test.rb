require "test_helper"

class ItemCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create(name: "User", email: "user@example.com", password: "password", password_confirmation: "password")
    @item = Item.new(title: "Item 1", description: "This is a valid description.", quantity: 5, price: 10.0, user_id: @user.id)
    unless @item.save
      puts "Item errors: #{@item.errors.full_messages}"
    end
    @category = Category.new(name: "Category 1")
    unless @category.save
      puts "Category errors: #{@category.errors.full_messages}"
    end
    @item_category = ItemCategory.new(item_id: @item.id, category_id: @category.id)
  end

  test "should be valid" do
    assert @item_category.valid?
  end

  test "should require item_id" do
    @item_category.item_id = nil
    assert_not @item_category.valid?
  end

  test "should require category_id" do
    @item_category.category_id = nil
    assert_not @item_category.valid?
  end

  test "should belong to item" do
    assert_equal @item, @item_category.item
  end

  test "should belong to category" do
    assert_equal @category, @item_category.category
  end
end
