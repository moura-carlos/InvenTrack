require "test_helper"

class ItemMailerTest < ActionMailer::TestCase
  test "stock" do
    mail = ItemMailer.stock
    assert_equal "Stock", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
