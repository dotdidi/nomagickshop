class ProductsController < ApplicationController
  before_action :set_cart
  before_action :admin_user, except: [:show, :index]

  def index
    @products = Product.paginate(page: params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def update
    @product = Product.find params[:id]
    if @product.update(prd_params)
      redirect_to @product, notice: 'Product was updated.'
    else
      flash.now[:error] = "Product was failed to update."
      render :edit
    end
  end

  def create 
    @product = Product.new(prd_params)
    if @product.save
      redirect_to @product, notice: 'Product has successfully created.'
    else
      flash.now[:error] = "Error in creating the product."
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    if @product.destroyed?
      flash[:success] = "Product is deleted."
    else
      flash[:error] = "Product can not be deleted."
    end
    redirect_to products_url
  end

  private

  def prd_params
    params.require(:product).permit(:title, :desc, :img_url, :price)
  end

  def admin_user
    unless @current_user.present? && @current_user.admin? 
      flash[:danger] = "You are not authorized to do this actions"
      redirect_to(welcome_url)
    end
  end
end
