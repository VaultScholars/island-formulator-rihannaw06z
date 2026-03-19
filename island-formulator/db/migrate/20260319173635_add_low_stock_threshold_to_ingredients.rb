class AddLowStockThresholdToIngredients < ActiveRecord::Migration[8.1]
  def change
    add_column :ingredients, :low_stock_threshold, :decimal
  end
end
