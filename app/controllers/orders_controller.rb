class OrdersController < ApplicationController
  before_action :ensure_has_line_items, only: [:new, :create]
  before_action :set_order_up, except: [:new, :create]
  before_action :ensure_own_user, only: :destroy
  before_action :ensure_has_shipped, only: :destroy


  def new
    if session[:user_id].present?
      # make order with user data
      @order = Order.new({
        first_name: @current_user.realname.split(' ',2).first,
        last_name: @current_user.realname.split(' ',2).last,
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
      flash[:success] = "You order have been recieved"
      cut_line_items_and_redirect
      @order.delay(run_at: 1.weeks.from_now).ship_the_order
    else
      flash.now[:error] = "Your order contains error"
      render 'new'
    end
  end

  def destroy
    @order.destroy
    flash[:success] = "Your order history has been deleted"
    redirect_to @current_user
  end

  private

  def cut_line_items_and_redirect
    @current_cart.line_items.each do |cart_item|
      cart_item.order_id = @order.id
      cart_item.save
    end
    if @order.pay_type = "Credit"
      redirect_to new_transaction_url
    else
      redirect_to @order
    end
  end

  def set_order_up
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :address, :ip_address, :pay_type)
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

  def ensure_own_user
    unless @current_user.present? && @current_user.id == @order.user_id
      flash[:error] = "Error in accessing history"
      redirect_to root_url
    end
  end

end
