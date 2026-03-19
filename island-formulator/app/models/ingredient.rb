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

  def current_unit_price
    # Returns the average price per unit for all inventory items of this ingredient that are currently in stock
    in_stock = inventory_items.where("quantity > 0")
    return nil if in_stock.empty?

    total_value = in_stock.sum { |item| item.unit_price * item.quantity }
    total_qty = in_stock.sum(:quantity)
    total_value/total_qty
  end
  def total_qty
    inventory_items.sum(:quantity)
  end
  def unit
    units = inventory_items.distinct.pluck(:unit)
    return nil if units.empty?
    return units.first if units.one?
    :mixed
  end
  def low_stock?
    return false if low_stock_threshold.blank?
    total_qty <= low_stock_threshold
  end
end
