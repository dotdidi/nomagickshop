class LineItemsController < ApplicationController
  before_action :set_cart, only: :create
  before_action :set_input_value, only: [:create, :update]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def edit
  end

  def show
  end

  def create
    @line_item = @current_cart.add_product(@product, @add_quantity)
    flash[:success] = "Item added to the cart"
    redirect_to root_url
  end

  def update
    @line_item.quantity = @add_quantity
    if @line_item.update(line_item_params)
      flash[:success] = "Item cart updated"
    else
      flash[:error] = "Item failed to update"
    end
    redirect_to cart_url
  end

  def destroy
    @line_item.destroy
    flash[:success] = "Item successfully destroyed"
    redirect_to (request.referer.present? ? :back : root_path)
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def set_input_value
    @product = Product.find(line_item_params[:product_id])
    @add_quantity = line_item_params[:add_quantity].to_i
  end

  def line_item_params
    params.require(:line_item).permit(:product_id, :cart_id, :add_quantity)
  end

end
