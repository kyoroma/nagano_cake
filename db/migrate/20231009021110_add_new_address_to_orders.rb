class AddNewAddressToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :new_address, :string
  end
end
