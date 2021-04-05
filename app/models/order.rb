class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  validates :date, :total, :user_id, :status, presence: true
  validates :total, numericality: { only_integer: true }

  # order status'
  # 0 - open
  # 1 - paid
  # 2 - shipped
  # 3 - complete
end
