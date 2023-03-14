require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "should not save category without name" do
    category = Category.new
    assert_not category.save, "Saved the category without a name"
  end

  test "should not save category with duplicate name (case insensitive)" do
    category1 = Category.create(name: "Category1")
    category2 = Category.new(name: "category1")
    assert_not category2.save, "Saved the category with a duplicate name"
  end

  test "should not save category with name length less than 3" do
    category = Category.new(name: "A")
    assert_not category.save, "Saved the category with a name length less than 3"
  end

  test "should not save category with name length more than 50" do
    category = Category.new(name: "A" * 51)
    assert_not category.save, "Saved the category with a name length more than 50"
  end

  test "should downcase the name attribute before validation" do
    category = Category.new(name: "CATEGORY")
    category.valid?
    assert_equal "category", category.name
  end

  test "should return items of current user" do
    user1 = User.create(name: "User1", email: "user1@example.com", password: "password", password_confirmation: "password")
    user2 = User.create(name: "User2", email: "user2@example.com", password: "password", password_confirmation: "password")
    category = Category.create(name: "Category")
    item1 = Item.create(title: "Item1",description: "This is the description for Item1", quantity: 10, price: 0.75, user_id: user1.id)
    item2 = Item.create(title: "Item2",description: "This is the description for Item2", quantity: 15, price: 1.25, user_id: user2.id)
    ItemCategory.create(item: item1, category: category)
    ItemCategory.create(item: item2, category: category)
    assert_equal [item1], category.user_items(user1)
  end
end
