class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :user
  helper_method :categories

  private

  def initialize_session
    session[:shopping_cart] ||= {}
    session[:user] ||= User.first
  end

  def user
    User.find(session[:user])
  end

  def categories
    Category.all
  end
end
