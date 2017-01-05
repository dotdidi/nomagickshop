class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CurrentCart
  before_action :set_cart
  before_action :set_current_user

  private
  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id].present?
  end

  def user_logged_in?
    unless @current_user.present?
      flash[:danger] = "Please log in."
      redirect_to welcome_url
    end
  end
end
