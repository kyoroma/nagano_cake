class AddPostalCodeToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :postal_code, :string
  end
end
