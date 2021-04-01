class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart
  helper_method :user

  private

  def initialize_session
    session[:shopping_cart] ||= ["this is the cart session"]
    session[:user] ||= User.where("username LIKE 'Guest'").first.id
  end

  def cart
    Product.find(session[:shopping_cart])
  end

  def user
    # User.first
    User.find(session[:user])
  end
end
