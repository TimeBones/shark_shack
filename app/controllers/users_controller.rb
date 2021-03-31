class UsersController < ApplicationController
  def show
    # some if logic to verify the user is logged in
    # or to find the id of the user that is logged in and then there is no user looking around lmao what a great idea you genius
    @user = User.find(params[:id])
  end
end
