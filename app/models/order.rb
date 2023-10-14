class Order < ApplicationRecord
 belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_one :shipping_address, class_name: 'Address'

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { pending: 0, confirmed: 1, shipped: 2, delivered: 3 }

  validates :shipping_fee, :payment_method, :total_price, :name, :address, :postal_code, presence: true

  def save_order_information(customer, shipping_address, payment_method, shipping_fee)
    self.customer = customer
    self.shipping_address = shipping_address
    self.payment_method = payment_method
    self.shipping_fee = shipping_fee
    self.total_price = calculate_total_price
    self.status = :confirmed

    self.save
    clear_cart_items
  end

  def calculate_total_price
    cart_items.sum { |cart_item| cart_item.subtotal } + shipping_fee
  end

  def clear_cart_items
    customer.cart_items.destroy_all
  end
end