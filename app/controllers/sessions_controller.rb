class SessionsController < ApplicationController

  def new
  end

  def create
  	@user = User.find_by(email: params[:session][:email].downcase)
  	if @user && @user.authenticate(params[:session][:password])
  	  log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # if '1', remember user, else, forget user
  	  redirect_back_or @user
  	  # same as   user_url(user)
  	elsif params[:session][:email].blank?
  		flash.now[:danger] = "Enter your email and password"
  	  render 'new'
    elsif user.nil?
    	flash.now[:danger] = "Email is not registered"
    	render 'new'
    else
      flash.now[:danger] = "Incorrect password"
      render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
