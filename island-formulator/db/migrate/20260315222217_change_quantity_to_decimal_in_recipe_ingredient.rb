class ChangeQuantityToDecimalInRecipeIngredient < ActiveRecord::Migration[7.1]
  def up
    # Converts empty strings or invalid values to 0
    execute <<~SQL
      UPDATE recipe_ingredients
      SET quantity = '0'
      WHERE quantity IS NULL
         OR quantity = ''
         OR trim(quantity) = '';
    SQL

    # Safely changes the column type
    change_column :recipe_ingredients, :quantity, :decimal,
                  precision: 10, scale: 2, using: "quantity::numeric"
  end

  def down
    change_column :recipe_ingredients, :quantity, :string
  end
end
