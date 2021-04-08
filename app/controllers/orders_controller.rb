class OrdersController < ApplicationController
  def index
    @orders = Order.where(user: user)
  end

  def show
    id = params[:id].to_i
    @order = Order.where(id: id, user: user)
    if @order.size.zero?
      flash[:notice] = "Unauthorized"
      redirect_to root_path
    end
  end
end
