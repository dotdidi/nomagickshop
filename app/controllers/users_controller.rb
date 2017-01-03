class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :show]

  def index
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to No Magick Shop."
      log_in @user
      redirect_to products_url
    else
      flash[:error] = "Error in creating user, please try again later."
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      flash[:error] = "Profile can not be updated for the moment."
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Thanks for your patronage."
    redirect_to products_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_back unless @user.id == current_user.id
    flash[:danger] = "You are not allowed to be here"
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to welcome_url
    end
  end
end
