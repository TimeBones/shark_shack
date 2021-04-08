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

    tax_amount = (sum * line_tax["rate"]).round

    tax =
      {
        name:     line_tax["label"],
        amount:   tax_amount,
        currency: "cad",
        quantity: 1
      }

    line_items << tax

    session[:taxes] = [line_tax, tax_amount]
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
    @pi_data = payment_intent[:charges][:data][0]
    @total = stripe_session[:amount_total].to_i
    @subtotal = (@total - line_tax[1])

    cart = session[:shopping_cart]

    order = Order.create(total:     @total,
                         tax:       line_tax[1],
                         tax_rate:  line_tax[0]["rate"].to_f,
                         tax_label: (line_tax[0]["label"]),
                         date:      Time.zone.today,
                         user:      user,
                         status:    1)

    cart.each_pair do |key, value|
      product = Product.find(key)
      OrderProduct.create(order:    order,
                          product:  product,
                          price:    product.price,
                          quantity: value)
    end
    session[:shopping_cart].clear
    session[:taxes].clear
  end
end
