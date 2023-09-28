class Item < ApplicationRecord
  has_one_attached :image
  include Kaminari::PageScopeMethods
  
  def tax_included_price
    self.price * 1.1
  end
end
