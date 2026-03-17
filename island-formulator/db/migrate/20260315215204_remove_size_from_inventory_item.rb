class RemoveSizeFromInventoryItem < ActiveRecord::Migration[8.1]
  def change
    remove_column :inventory_items, :size, :string
  end
end
