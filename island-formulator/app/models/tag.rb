class Tag < ApplicationRecord
  # A Tag can be associated with many Ingredients through IngredientTags.
  has_many :ingredient_tags, dependent: :destroy
  has_many :ingredients, through: :ingredient_tags

  validates :name, presence: true, uniqueness: true
end
