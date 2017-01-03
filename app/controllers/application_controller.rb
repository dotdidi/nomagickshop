class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to welcome_url
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
end
