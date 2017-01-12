class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
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

  def new_session_cart
    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
  end

  def set_cart
    if session[:cart_id].nil?
      new_session_cart
    else
      @current_cart ||= Cart.find(session[:cart_id]) 
    end
  rescue ActiveRecord::RecordNotFound
    if Rails.env.development? || Rails.env.test?
      new_session_cart
    end
  end

end
