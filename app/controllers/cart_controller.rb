class CartController < ApplicationController
  def create
    id = params[:id].to_i
    qty = params[:qty].to_i

    session[:shopping_cart] << { id => qty }
    # product = Product.find(id)
    # flash[:notice] = "Added #{product.name} to the cart."
    # redirect_to root_path
    @cart = session[:shopping_cart]

  end

  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    product = Product.find(id)
    flash[:notice] = "Removed #{product.name} from the cart."
    redirect_to root_path
  end

  def view
    @cart = session[:shopping_cart]
  end
end
