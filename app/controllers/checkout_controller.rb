class CheckoutController < ApplicationController
  def create
    @product = Product.find(params[:product_id])

    if @product.nil?
      redirect_to root_path
      return
    end

    respond_to do |format|
      format.js
    end
  end
end
