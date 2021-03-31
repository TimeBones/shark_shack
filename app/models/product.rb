class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  validates :name, :price, :desc, :status, :weight, presence: true
  validates :price, :status, :weight, is_numeric: true
  has_one_attached :image
end
