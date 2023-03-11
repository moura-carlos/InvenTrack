class ItemMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.item_mailer.stock.subject
  #
  def stock(item, current_user)
    # make sure I can access the item in the view
    @item = item
    @user = current_user
    if item.quantity.zero?
      mail to: current_user.email, subject: "#{@item.title} is out of stock!"
    end
  end
end
