class CheckoutController < ApplicationController
  def view
    @cart = session[:shopping_cart]
    @address = user.address
    @prov = []
    taxes.each_pair do |k, v|
      @prov << [v["province"], k]
    end
  end

  def cancel; end

  def create
    cart = session[:shopping_cart]
    line_tax = taxes[params[:province].to_s]

    line_items = []
    sum = 0
    cart.each_pair do |key, value|
      product = Product.find(key)
      sum += (product.price * value)
      item =
        {
          name:        product.name,
          description: product.desc,
          amount:      product.price,
          currency:    "cad",
          quantity:    value
        }

      line_items << item
    end

    tax =
      {
        name:     line_tax["label"],
        amount:   (sum * line_tax["rate"]).to_i,
        currency: "cad",
        quantity: 1
      }

    line_items << tax
    session[:taxes] = line_tax

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
    line_tax = session[:taxes]
    session[:taxes] = nil
    @pi_data = payment_intent[:charges][:data][0]
    @total = stripe_session[:amount_total].to_i
    @subtotal = (stripe_session[:amount_subtotal].to_i - (@total * line_tax["rate"])

    cart = session[:shopping_cart]
    session[:shopping_cart].clear

    order = Order.create(total:  @total,
                         tax: (@total - @subtotal),
                         tax_rate: (line_tax["rate"]),
                         tax_label: (line_tax["label"]),
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
  end
end
