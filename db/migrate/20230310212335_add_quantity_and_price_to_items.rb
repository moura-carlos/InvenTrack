class AddQuantityAndPriceToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :quantity, :integer, null: false, default: 0
    add_column :items, :price, :decimal, precision: 8, scale: 2, null: false, default: 0.00
  end
end
