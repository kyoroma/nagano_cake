class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_initialize :set_defaults, unless: :persisted?

   has_many :cart_items
   has_many :addresses
   has_many :orders

  def full_name
    "#{last_name} #{first_name}"
  end

  def full_name_kana
    "#{last_name_kana} #{first_name_kana}"
  end

  def set_defaults
    self.is_active = true if self.is_active.nil?
  end

  validates :password, presence: true, length: { minimum: 6 }, on: :create
end
