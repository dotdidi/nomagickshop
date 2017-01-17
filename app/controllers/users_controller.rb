class UsersController < ApplicationController
  before_action :user_logged_in?, except: [:new, :create]
  before_action :is_own_user?, only: [:edit, :update, :show, :destroy]

  def index
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to No Magick Shop."
      session[:user_id] = @user.id
    else
      flash[:error] = "Error in creating user, please try again later."
    end
      redirect_to products_url
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      flash.now[:error] = "Profile can not be updated for the moment."
      render 'edit'
    end
  end

  def destroy
    session[:user_id] = nil
    User.find(params[:id]).destroy
    flash[:success] = "Thanks for your patronage."
    redirect_to products_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :realname, :address, :phone, :password, :password_confirmation)
  end

  def is_own_user?
    @user = User.find(params[:id])
    unless @user.id == @current_user.id
      flash[:danger] = "You are not allowed to be here"
      redirect_to users_url
    end
  end

end
