class AddTaxExcludedPriceToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :tax_excluded_price, :decimal

     Item.find_each do |item|
      item.update(tax_excluded_price: item.price.to_f / 1.1)
    end
  end
end
