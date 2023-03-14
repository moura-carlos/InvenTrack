require "test_helper"

class ItemMailerTest < ActionMailer::TestCase
  # test "stock" do
  #   mail = ItemMailer.stock
  #   assert_equal "Stock", mail.subject
  #   assert_equal ["to@example.org"], mail.to
  #   assert_equal ["from@example.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end
  test "stock" do
    user = users(:one)
    item = items(:one)
    item.update(quantity: 0) # Ensure the item is out of stock

    mail = ItemMailer.stock(item, user)
    assert_equal "#{item.title} is out of stock!", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["carlos@example.com"], mail.from
    assert_match "Dear #{user.name},", mail.body.encoded
    assert_match "the inventory for your item, #{item.title}, is currently out of stock.", mail.body.encoded
  end
end
