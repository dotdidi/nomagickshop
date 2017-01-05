class CartsController < ApplicationController
  before_action :set_cart, except: [:new, :create]

  def new
    @current_cart = Cart.new
  end

  def create
    @current_cart = Cart.new(cart_params)
    respond_to do |format|
      if @cart.save
        format.html {redirect_to @cart, notice: 'Cart was successfully created.'}
        format.json {render :show, status: :created, location: @cart }
      else
        format.html {render :new}
        format.json {render json: @cart.errors, status: :unprocessabel_entity}
      end
    end
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
    redirect_to root_url
  end

  private
  def cart_params
    params.fetch(:cart, {})
  end

end
