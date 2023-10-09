class AddNewNameToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :new_name, :string
  end
end
