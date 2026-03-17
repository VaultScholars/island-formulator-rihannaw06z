class InventoryItem < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
  has_one_attached :photo # allows us to attach a photo to each inventory item (receipt, etc.)

  validates :ingredient_id, presence: true
  validates :purchase_date, presence: true

  def unit_price
    # Returns the price per unit (e.g. per ml, per oz) for this inventory item
    return nil if quantity.nil? || quantity == 0
    price_cents.to_f / quantity
  end
  def price
    price_cents.to_f / 100
  end
end
