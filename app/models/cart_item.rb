class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  validates :amount, numericality: { greater_than: 0 }
  attr_accessor :total_price

  def subtotal
    item.with_tax_price * amount
  end
end
