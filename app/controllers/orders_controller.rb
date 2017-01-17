class OrdersController < ApplicationController
  before_action :ensure_has_line_items, only: [:new, :create]
  before_action :set_order_up, except: [:new, :create]
  before_action :ensure_has_shipped, only: :destroy


  def new
    if session[:user_id].present?
      # make order with user data
      @order = Order.new({
        name: @current_user.realname,
        email: @current_user.email,
        address: @current_user.address
      })
    else
      @order = Order.new
    end
  end

  def show
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = @current_user.id if @current_user.present?
    if @order.save
      cut_line_items
      flash[:success] = "You order have been recieved"
      redirect_to order_url(@order)
    end
  end

  def destroy
    if @current_user.present?
      destroy_own_order
      redirect_to user_url(@current_user)
    else
      flash[:error] = "You need to have an account 1st"
      redirect_to welcome_url
    end
  end

  private

  def cut_line_items
    @current_cart.line_items.each do |cart_item|
      cart_item.order_id = @order.id
      cart_item.save
    end
    session.delete(:cart_id)
  end

  def destroy_own_order
    if @current_user.id == @order.user_id and @order.destroy
      flash[:success] = "Your order history has been deleted"
    else
      flash[:error] = "Error in deleting history"
    end
  end

  def set_order_up
    @order = Order.find(params[:id])
    if @order.created_at <= 1.weeks.ago
      @order.shipped = true
      @order.save
    end
  end

  def order_params
    params.require(:order).permit(:name, :email, :address, :pay_type)
  end

  def ensure_has_line_items
    unless @current_cart.present? && @current_cart.line_items.present?
      flash[:error]= 'The Cart is Empty'
      redirect_to root_url
    end
  end

  def ensure_has_shipped
    if @order.shipped == true
      flash[:error] = "Order has been shipped"
      redirect_to order_url(@order)
    end
  end

end
