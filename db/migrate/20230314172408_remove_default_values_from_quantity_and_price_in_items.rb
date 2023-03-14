class RemoveDefaultValuesFromQuantityAndPriceInItems < ActiveRecord::Migration[7.0]
  def change
    change_column_default :items, :quantity, nil
    change_column_default :items, :price, nil
  end
end
