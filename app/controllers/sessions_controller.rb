class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Welcome back," + user.username
      redirect_to user
    else
      flash[:danger] = "Invalid User name or password"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to products_url
  end

end
