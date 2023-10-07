class Item < ApplicationRecord
  has_one_attached :image
  include Kaminari::PageScopeMethods
  
  def with_tax_price
    (price * 1.1).floor
  end
end
