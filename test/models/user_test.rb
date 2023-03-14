require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save user without name" do
    user = User.new(email: "test@example.com", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user without a name"
  end

  test "should not save user without email" do
    user = User.new(name: "Test User", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user without an email"
  end

  test "should not save user with invalid email format" do
    user = User.new(name: "Test User", email: "invalid_email_format", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user with an invalid email format"
  end

  test "should not save user with duplicate email" do
    User.create(name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password")
    user = User.new(name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user with a duplicate email"
  end

  test "should save user with valid attributes" do
    user = User.new(name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password")
    assert user.save, "Could not save the user with valid attributes"
  end
end
