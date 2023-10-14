class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  attr_accessor :total_price

  def subtotal
    item.with_tax_price * amount
  end
end
