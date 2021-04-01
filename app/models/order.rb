class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  validates :date, :subtotal, :user_id, :status, presence: true
  validates :subtotal, numericality: { only_integer: true }
end
