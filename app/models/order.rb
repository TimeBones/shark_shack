class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  validates :date, :total, :user_id, :status, presence: true
  validates :total, numericality: { only_integer: true }
end
