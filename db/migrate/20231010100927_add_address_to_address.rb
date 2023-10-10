class AddAddressToAddress < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :address, :string
  end
end
