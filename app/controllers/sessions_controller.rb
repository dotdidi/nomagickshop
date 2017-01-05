class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      @current_cart.user_id = user.id
      @current_cart.save
      flash[:success] = "Welcome back," + user.username
      redirect_to user
    else
      flash[:danger] = "Invalid User name or password"
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id) if @current_user.present?
    session.delete(:cart_id)
    redirect_to products_url
  end

end
