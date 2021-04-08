class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :order_products
  has_many :orders, through: :order_products
  validates :name, :price, :desc, :status, :weight, presence: true
  validates :price, :status, :weight, numericality: { only_integer: true }
  has_one_attached :image

  def self.top
    self.select("products.*")
        .select("COUNT(products.id) as buy_count")
        .joins(:order_products)
        .group("products.id")
        .order("buy_count DESC")
  end
end
