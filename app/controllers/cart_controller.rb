class CartController < ApplicationController
  def create
    id = params[:product_id].to_i
    qty = params[:qty].to_i
    product = Product.find(id)

    if product.nil?
      redirect_to root_path
      return
    end

    if session[:shopping_cart].key?(id.to_s)
      new_qty = session[:shopping_cart].fetch(id.to_s) + qty
      session[:shopping_cart][id] = new_qty
      message = "#{product.name} quantity increased to #{new_qty}"
    else
      session[:shopping_cart][id] = qty
      message = "Added #{product.name} to the cart."
    end

    @cart = session[:shopping_cart]
    flash[:notice] = message
    redirect_to params[:source].to_s
  end

  def destroy
    id = params[:product_id].to_i
    session[:shopping_cart].delete(id.to_s)
    product = Product.find(id)
    flash[:notice] = "Removed #{product.name} from the cart."
    redirect_to params[:source].to_s
  end

  def view
    @cart = session[:shopping_cart]
  end

  def empty
    session[:shopping_cart] = {}
    redirect_to root_path
  end

  def minus
    id = params[:product_id].to_i
    qty = params[:qty].to_i
    product = Product.find(id)

    if product.nil?
      redirect_to root_path
      return
    end

    if session[:shopping_cart].key?(id.to_s)
      new_qty = session[:shopping_cart].fetch(id.to_s) - qty
      if new_qty > 0
        session[:shopping_cart][id] = new_qty
      else
        session[:shopping_cart].delete(id.to_s)
      end
      flash[:notice] = "#{product.name} quantity decreased to #{new_qty}"
    end
    redirect_to params[:source].to_s
  end
end
