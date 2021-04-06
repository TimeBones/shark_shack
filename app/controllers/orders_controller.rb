class OrdersController < ApplicationController
  def index; end

  def show
    id = params[:id].to_i
    @order = Order.where(id: id, user: user)
    if @order.size == 0
      flash[:notice] = "Unauthorized"
      redirect_to root_path
    end
  end
end
