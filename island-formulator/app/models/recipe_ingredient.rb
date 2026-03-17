class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :ingredient

  def line_cost
    return 0 if quantity.blank? || ingredient.current_unit_price.nil?
    quantity * ingredient.current_unit_price
  end
end
