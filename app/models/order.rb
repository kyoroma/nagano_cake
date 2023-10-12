class Order < ApplicationRecord
  belongs_to :customer
  has_many :cart_items
  has_many :order_items, dependent: :destroy
  has_one :shipping_address, class_name: 'Address'

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { pending: 0, confirmed: 1, shipped: 2, delivered: 3 }

  validates :shipping_fee, :payment_method, :total_price, :name, :address, :postal_code, presence: true

  def confirmed!
    update(status: :confirmed)
    # ここで確定後の処理を実装する（例: 通知の送信、在庫の更新など）
    clear_cart_items
  end

  def clear_cart_items
    customer.cart_items.destroy_all
  end
end
