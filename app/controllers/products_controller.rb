class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @product_search = Product.where("name LIKE ?", "%#{params[:search]}%")
  end
end
