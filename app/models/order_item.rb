class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :amount, :final_price, presence: true
  def subtotal
    amount * final_price
  end
end
