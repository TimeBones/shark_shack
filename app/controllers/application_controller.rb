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
      "BC" => { "province" => "British Columbia",
                "rate"     => gst + bc_st,
                "label"    => "GST + PST" },
      "AB" => { "province" => "Alberta",
                "rate"     => gst,
                "label"    => "GST" },
      "SK" => { "province" => "Saskatchewan",
                "rate"     => gst + sk_st,
                "label"    => "GST + PST" },
      "MB" => { "province" => "Manitoba",
                "rate"     => gst + mb_st,
                "label"    => "GST + RST" },
      "ON" => { "province" => "Ontario",
                "rate"     => ot_hst,
                "label"    => "HST" },
      "QU" => { "province" => "Quebec",
                "rate"     => gst + qu_st,
                "label"    => "GST + QST" },
      "NF" => { "province" => "Newfoundland and Labrador",
                "rate"     => hst,
                "label"    => "HST" },
      "PE" => { "province" => "Prince Edward Island",
                "rate"     => hst,
                "label"    => "HST" },
      "NB" => { "province" => "New Brunswick",
                "rate"     => hst,
                "label"    => "HST" },
      "NS" => { "province" => "Nova Scotia",
                "rate"     => hst,
                "label"    => "HST" },
      "YK" => { "province" => "Yukon",
                "rate"     => gst,
                "label"    => "GST" },
      "NT" => { "province" => "Northwest Territories",
                "rate"     => gst,
                "label"    => "GST" },
      "NV" => { "province" => "Nunavut",
                "rate"     => gst,
                "label"    => "GST" }
    }
  end
end
