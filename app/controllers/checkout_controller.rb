class CheckoutController < ApplicationController
  def create
    @product = Product.find(params[:product_id])

    if @product.nil?
      redirect_to root_path
      return
    end

    # @session = Stripe::Checkout::Session.create(
    #   payment_method_types: ["card"],
    #   success_url:          checkout_success_url,
    #   cancel_url:           checkout_cancel_url,
    #   line_items:           [
    #     {
    #       name:        product.name,
    #       description: product.desc,
    #       amount:      product.price,
    #       currency:    "cad",
    #       quantity:    1 # example
    #     }
    #   ]
    # )

    # ensure it formats the response as .js instead of .html:
    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success; end

  def cancel; end
end
