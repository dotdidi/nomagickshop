class LineItemsController < ApplicationController
  before_action :set_cart, only: :create
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
    @product = Product.find(line_item_params[:product_id])
    @add_quantity = line_item_params[:add_quantity].to_i
    @line_item = @current_cart.add_product(@product, @add_quantity)
    respond_to do |format|
      flash[:success] = "Item added to the cart"
      format.html {redirect_to root_url} 
      format.json {render :show, status: :created, location: @line_item }
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        flash[:success] = "Item cart updated"
        format.html { redirect_to (@current_cart)}
        format.json { render :show, status: :ok, location: @line_item }
      else
        flash[:error] = "Cart failed to update"
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      flash[:success] = "Item successfully destroyed"
      format.html { redirect_to (request.referer.present? ? :back : root_path) }
      format.json { head :no_content}
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:product_id, :cart_id, :add_quantity)
  end

end
