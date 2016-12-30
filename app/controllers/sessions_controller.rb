class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username:params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Welcome back," + user.username
      redirect_to products_url
    else
      flash[:success] = "Welcome to No Magick Shop"
      redirect_to products_url
    end
  end

  def destroy
    log_out
    redirect_to users_url
  end

end
