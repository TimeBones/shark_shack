class PagesController < ApplicationController
  def search
    @search = params[:search]
    # @search = if params[:search_page].nil?
    #             params[:search_nav]
    #           else
    #             params[:search_page]
    #           end
    @category = params[:category]
    @cats = ["Category"]

    categories.map { |cat| @cats << cat.name }

    @find = @cats.include?(@category)

    if @category == "All" || @category == "Category"
      @results = Product.where("name LIKE ? OR desc LIKE ?",
                               "%#{@search}%",
                               "%#{@search}%")
    elsif @cats.include?(@category)
      @results = Category.find_by(name: @category).products.where("name LIKE ? OR desc LIKE ?",
                                                                  "%#{@search}%",
                                                                  "%#{@search}%")
    else
      flash[:notice] = "Invalid Category"
     end
  end
end
