class AddAddressTypeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :address_type, :string
  end
end
