class Order < ApplicationRecord
  belongs_to :user
  validates :date, :subtotal, :user_id, :status, presence: true
  validates :subtotal, is_numeric: true
end
