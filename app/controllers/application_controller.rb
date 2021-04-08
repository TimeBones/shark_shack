class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :user
  helper_method :categories
  helper_method :taxes

  private

  def initialize_session
    session[:shopping_cart] ||= {}
    session[:user] ||= User.first.id
  end

  def user
    User.find(session[:user])
  end

  def categories
    Category.all
  end

  def taxes
    gst = 0.05      # GST
    bc_st = 0.07    # British Columia sales tax
    mb_st = 0.07    # Manitoba sales tax
    qu_st = 0.09975 # Quebec sales tax
    sk_st = 0.06    # Saskatchewan sales tax
    ot_hst = 0.13   # Ontario harmonized sales tax
    hst = 0.15      # Harmonized sales tax

    {
      "BC" => {
        "rate"     => (gst + bc_st).round(2),
        "province" => "British Columbia",
        "label"    => "GST + PST"
      },
      "AB" => {
        "rate"     => gst,
        "label"    => "GST",
        "province" => "Alberta"
      },
      "SK" => {
        "rate"     => (gst + sk_st).round(2),
        "label"    => "GST + PST",
        "province" => "Saskatchewan"
      },
      "MB" => {
        "rate"     => (gst + mb_st).round(2),
        "label"    => "GST + RST",
        "province" => "Manitoba"
      },
      "ON" => {
        "rate"     => ot_hst,
        "label"    => "HST",
        "province" => "Ontario"
      },
      "QU" => {
        "rate"     => (gst + qu_st).round(5),
        "label"    => "GST + QST",
        "province" => "Quebec"
      },
      "NF" => {
        "rate"     => hst,
        "label"    => "HST",
        "province" => "Newfoundland and Labrador"
      },
      "PE" => {
        "rate"     => hst,
        "label"    => "HST",
        "province" => "Prince Edward Island"
      },
      "NB" => {
        "rate"     => hst,
        "label"    => "HST",
        "province" => "New Brunswick"
      },
      "NS" => {
        "rate"     => hst,
        "label"    => "HST",
        "province" => "Nova Scotia"
      },
      "YK" => {
        "rate"     => gst,
        "label"    => "GST",
        "province" => "Yukon"
      },
      "NT" => {
        "rate"     => gst,
        "label"    => "GST",
        "province" => "Northwest Territories"
      },
      "NV" => {
        "rate"     => gst,
        "label"    => "GST",
        "province" => "Nunavut"
      }
    }
  end
end
