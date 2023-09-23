class AddIsActiveToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :is_active, :boolean
    add_column :customers, :default, :string
    add_column :customers, :true, :string
  end
end
