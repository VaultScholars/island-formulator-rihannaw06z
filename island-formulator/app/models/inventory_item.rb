class InventoryItem < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
  has_one_attached :photo # allows us to attach a photo to each inventory item (receipt, etc.)

  validates :ingredient_id, presence: true
  validates :purchase_date, presence: true
end
