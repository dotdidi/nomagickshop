class CartsController < ApplicationController
  before_action :set_cart, except: [:new, :create]

  def new
  end

  def create
  end

  def show
  end

  def destroy
    if @current_cart.id == session[:cart_id]
      @current_cart.line_items.each do |item|
        item.delete
      end
    end
    flash[:success] = "Your cart has been emptied"
    redirect_to cart_url
  end

end
