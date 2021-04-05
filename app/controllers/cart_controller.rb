class CartController < ApplicationController
  def create
    id = params[:id].to_i
    qty = params[:qty].to_i

    session[:shopping_cart][id] = if session[:shopping_cart].key?(id.to_s)
                                    session[:shopping_cart].fetch(id.to_s) + qty
                                  else
                                    qty
                                  end
    product = Product.find(id)
    flash[:notice] = "Added #{product.name} to the cart."
    @cart = session[:shopping_cart]
    redirect_to root_path
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
