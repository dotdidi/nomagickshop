require 'users_helper'

class ProductsController < ApplicationController
  before_action :set_user, except: [:show, :index, :update]
  before_action :admin_user, except: [:show, :index]

  def index
    @products = Product.all
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
    respond_to do |u|
      if @product.update(prd_params)
        u.html {redirect_to @product, notice: 'Product was updated'}
        u.json {render :show, status: :ok, location: @product}
      else
        u.html {render :edit}
        u.json {render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def create 
    @product = Product.new(prd_params)
    respond_to do |c|
      if @product.save
        c.html {redirect_to @product, notice: 'Product has successfully created.'}
        c.json {render :show, status: created, location: @product}
      else
        c.html {render :new}
        c.json {render json: @product.errors, status: :unproccessable_entity}
      end
    end
  end

  private

  def prd_params
    params.require(:product).permit(:title, :desc, :img_url, :price)
  end

  def admin_user
    redirect_to(users_url) unless current_user.admin?
  end

end
