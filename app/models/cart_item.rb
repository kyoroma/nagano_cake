class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
