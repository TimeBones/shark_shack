class UsersController < ApplicationController
  def create
    @name = User.find_by(username: params[:username].strip.downcase)
    @email = User.find_by(email: params[:email].strip.downcase)

    if @name.class.to_s == "User"
      respond_to do |format|
        format.html { redirect_to new_account_path, notice: "Username was already taken." }
        format.json { render new_account_path }
      end
    elsif @email.class.to_s == "User"
      respond_to do |format|
        format.html { redirect_to new_account_path, notice: "Email is already in use." }
        format.json { render new_account_path }
      end
    else
      @user = User.new(username:   params[:username].strip.downcase,
                       password:   "thisisthepassword",
                       passphrase: params[:passphrase].strip,
                       email:      params[:email].strip.downcase,
                       powerlevel: 1,
                       active:     1)

      respond_to do |format|
        if @user.save
          session[:user] = @user.id
          format.html { redirect_to account_path, notice: "User was successfully created." }
          format.json { render account_path, status: :created, location: @user }
        else
          format.html { redirect_to new_account_path, alert: "User was not created" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def logout
    session[:user] = User.where("username LIKE 'Guest'").first.id
    redirect_to root_path
  end

  def logging
    @log = User.where(username:   params[:username].strip.downcase,
                      passphrase: params[:passphrase].strip).first

    if @log.class.to_s == "User"
      session[:user] = @log.id.to_i
      redirect_to account_path
    else
      respond_to do |format|
        format.html do
          redirect_to user_login_path, alert: "Username or password was incorrect."
        end
        format.json { head :no_content }
      end
    end
  end
end
