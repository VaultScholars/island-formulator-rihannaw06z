class Ingredient < ApplicationRecord
  # Every ingredient must belong to a user
  belongs_to :user

  # This allows us to say @ingredient.tags and get a list of all tags!
  has_many :ingredient_tags, dependent: :destroy
  has_many :tags, through: :ingredient_tags
  has_many :inventory_items, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_one_attached :photo

  validates :name, presence: true
  validates :category, presence: true
  validates :user, presence: true # ensures every ingredient has user present
end
