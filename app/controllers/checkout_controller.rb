class CheckoutController < ApplicationController
  def create
    cart = session[:shopping_cart]

    line_items = []
    cart.each_pair do |key, value|
      product = Product.find(key)
      item =
        {
          name:        product.name,
          description: product.desc,
          amount:      product.price.to_i,
          currency:    "cad",
          quantity:    value
        }

      line_items << item
    end

    # Establish a connection with Stripe and then redirect the user to the payment screen.
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           line_items
    )

    respond_to :html
  end

  def success
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])
    payment_intent = Stripe::PaymentIntent.retrieve(stripe_session.payment_intent)

    @pi_data = payment_intent[:charges][:data][0]
    @total = stripe_session[:amount_total].to_i
    @subtotal = stripe_session[:amount_subtotal].to_i

    # start creating the orders and apply them to the user!!!
    cart = session[:shopping_cart]

    order = Order.create(total:  @total,
                         date:   Time.zone.today,
                         user:   user,
                         status: 1)

    cart.each_pair do |key, value|
      product = Product.find(key)
      OrderProduct.create(order:    order,
                          product:  product,
                          price:    product.price,
                          quantity: value)
    end
    session[:shopping_cart].clear
  end

  def cancel; end
end
