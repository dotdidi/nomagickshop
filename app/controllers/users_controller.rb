require 'users_helper'

class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]

  def index
    @user = User.find_by(params[:id])
    @product = Product.find_by(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to No Magick Shop."
      redirect_to products_url
    else
      flash[:error] = "Error in creating user, please try again later."
      render 'new'
    end
  end

  def update
    @user = User.find_by(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      flash[:error] = "Profile can not be updated for the moment."
      render 'edit'
    end
  end

  def destroy
    User.find_by(params[:id]).destroy
    flash[:success] = "Thanks for your patronage."
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless :logged_in?
      flash[:danger] = "Please log in."
      redirect_to '#'
    end
  end
end
