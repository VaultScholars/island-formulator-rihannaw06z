class AddCostToInventoryItem < ActiveRecord::Migration[8.1]
  def change
    add_column :inventory_items, :price_cents, :integer
    add_column :inventory_items, :quantity, :decimal
    add_column :inventory_items, :unit, :string
  end
end
