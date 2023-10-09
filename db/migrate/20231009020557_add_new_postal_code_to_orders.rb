class AddNewPostalCodeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :new_postal_code, :string
  end
end
