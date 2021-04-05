class CheckoutController < ApplicationController
  def create
    order = Product.find(params[:product_id])

    if order.nil?
      redirect_to root_path
      return
    end

    # Establish a connection with Stripe and then redirect the user to the payment screen.
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           [
        {
          name:        product.name,
          description: product.desc,
          amount:      product.price.to_i,
          currency:    "cad",
          quantity:    1
        }
      ]
    )

    respond_to :html
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    payment_intent = Stripe::PaymentIntent.retrieve(session.payment_intent)

    @pi_data = payment_intent[:charges][:data][0]
    @total = session[:amount_total].to_f
    @subtotal = session[:amount_subtotal].to_f
  end

  def cancel; end
end
