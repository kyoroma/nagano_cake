class Item < ApplicationRecord
  has_one_attached :image
  include Kaminari::PageScopeMethods
end
