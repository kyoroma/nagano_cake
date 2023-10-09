class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_one :shipping_address, class_name: 'Address'
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  validates :shipping_fee, :payment_method, :total_price, :name, :address, :postal_code, presence: true
end
