class TransactionsController < ApplicationController
  before_action :set_order_id

  def new
    @transaction = Transaction.new
  end

  def show
  end

  def create
    @transaction = @order.transactions.new(payment_details)
    if @transaction.save
      @transaction.update_attributes(ip_address: request.remote_ip)
      if @transaction.transact
        # success
        @order.delay(run_at: 1.weeks.from_now).ship_the_order
        flash[:success] = 'Success!'
        session.delete(:cart_id)
      else
        # failure
        flash[:error] = 'Failure!'
      end
      redirect_to order_url(@order)
    else render 'new'

    end

  end

  private

  def set_order_id
    @order = Order.find_by(id: @current_cart.line_items.first.order_id)
  end

  def payment_details
    params.require(:transaction).permit(:card_number, :card_verification, :card_expires_on, :card_type, :ip_address)
  end
end
