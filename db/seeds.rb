# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Create users
user1 = User.create!(name: "Admin User", email: "admin@example.com", password: "password", password_confirmation: "password", is_admin: true)
user2 = User.create!(name: "Regular User", email: "user@example.com", password: "password", password_confirmation: "password", is_admin: false)

# Create items
item1 = Item.create!(title: "Item 1", description: "This is the description for the sample item 1", quantity: 10, price: 12.99, user_id: user1.id)
item2 = Item.create!(title: "Item 2", description: "This is the description for the sample item 2", quantity: 5, price: 19.99, user_id: user1.id)
item3 = Item.create!(title: "Item 3", description: "This is the description for the sample item 3", quantity: 15, price: 9.99, user_id: user2.id)

# Create categories
category1 = Category.create!(name: "Electronics")
category2 = Category.create!(name: "Books")
category3 = Category.create!(name: "Clothing")

# Assign categories to items
ItemCategory.create!(item_id: item1.id, category_id: category1.id)
ItemCategory.create!(item_id: item2.id, category_id: category2.id)
ItemCategory.create!(item_id: item3.id, category_id: category3.id)
