class AddDefaultShippingFeeToOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :shipping_fee, :integer, default: 800
  end
end
