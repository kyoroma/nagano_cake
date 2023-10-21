class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :amount, null: false
      t.integer :final_price, null: false
      t.integer :order_id
      t.integer :item_id
      
      t.timestamps
    end
  end
end
